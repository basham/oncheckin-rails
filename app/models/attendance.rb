# == Schema Information
#
# Table name: attendances
#
#  id             :integer          not null, primary key
#  participant_id :integer
#  event_id       :integer
#  tags           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Attendance < ActiveRecord::Base
	belongs_to :participant
	belongs_to :event
	acts_as_taggable_on :tags

	after_save :calculate_affiliation_counts
	before_destroy :calculate_affiliation_counts

	def chapter
		event.chapter
	end

	def host?
		tag_list.include? 'host'
	end

	def calculate_affiliation_counts
		# Preload queries
		_attended_events = participant.events.where(chapter_id: event.chapter_id)
		_hosts = participant.hosts_by_chapter(event.chapter_id)
		affiliation = participant.affiliations.where(chapter_id: event.chapter_id).first

		# All new events
		future_attendance_count = _attended_events.where('start_time > ?', affiliation.recorded_since).count
		future_host_count = _hosts.where('events.start_time > ?', affiliation.recorded_since).count

		# All past events, which should already be included in the recorded counters,
		# assuming those records are correct
		past_attendance_count = _attended_events.count - future_attendance_count
		past_host_count = _hosts.count - future_host_count

		# Best guesses, accomodating events not yet in the database
		affiliation.unrecorded_attendance_count = affiliation.recorded_attendance_count - past_attendance_count
		affiliation.unrecorded_host_count = affiliation.recorded_host_count - past_host_count

		# Actual, live counts
		affiliation.attendance_count = affiliation.recorded_attendance_count + future_attendance_count
		affiliation.host_count = affiliation.recorded_host_count + future_host_count

		affiliation.save
	end
end
