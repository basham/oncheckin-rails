# == Schema Information
#
# Table name: attendances
#
#  id         :integer          not null, primary key
#  hasher_id  :integer
#  event_id   :integer
#  tags       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Attendance < ActiveRecord::Base
	belongs_to :hasher
	belongs_to :event
	acts_as_taggable_on :tags

	after_save :calculate_affiliation_counts

	def serializable_hash(options={})
		default = { except: [:created_at, :updated_at, :tags, :event_id] }
		options = options.merge(default) { |k, x, y| x + y }
		hash = super options
		hash[:tags] = tag_list - ['hare']
		hash[:hare] = hare?
		#hash[:virgin] = virgin?
		#hash[:visitor] = visitor?
		hash
	end

	def kennel
		event.kennel
	end

	def hare?
		tag_list.include? 'hare'
	end

	def virgin?
		tag_list.include? 'virgin'
	end

	def visitor?
		tag_list.include? 'visitor'
	end

	def calculate_affiliation_counts
		# Preload queries
		_attended_events = hasher.events.where(kennel_id: event.kennel_id)
		_hares = hasher.hares_by_kennel(event.kennel_id)
		affiliation = hasher.affiliations.where(kennel_id: event.kennel_id).first

		# All new events
		future_attendance_count = _attended_events.where('start_time > ?', affiliation.recorded_since).count
		future_hare_count = _hares.where('events.start_time > ?', affiliation.recorded_since).count

		# All past events, which should already be included in the recorded counters,
		# assuming those records are correct
		past_attendance_count = _attended_events.count - future_attendance_count
		past_hare_count = _hares.count - future_hare_count

		# Best guesses, accomodating events not yet in the database
		affiliation.unrecorded_attendance_count = affiliation.recorded_attendance_count - past_attendance_count
		affiliation.unrecorded_hare_count = affiliation.recorded_hare_count - past_hare_count

		# Actual, live counts
		affiliation.attendance_count = affiliation.recorded_attendance_count + future_attendance_count
		affiliation.hare_count = affiliation.recorded_hare_count + future_hare_count

		affiliation.save
	end
end
