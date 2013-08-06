# == Schema Information
#
# Table name: affiliations
#
#  id                          :integer          not null, primary key
#  participant_id              :integer
#  chapter_id                  :integer
#  recorded_attendance_count   :integer
#  recorded_host_count         :integer
#  recorded_since              :date
#  unrecorded_attendance_count :integer
#  unrecorded_host_count       :integer
#  attendance_count            :integer
#  host_count                  :integer
#  created_at                  :datetime
#  updated_at                  :datetime
#

class Affiliation < ActiveRecord::Base
	belongs_to :chapter
	belongs_to :participant

	def serializable_hash(options={})
		default = { except: [:created_at, :updated_at] }
		options = options.merge(default) { |k, x, y| x + y }
		super options
	end
end
