# == Schema Information
#
# Table name: affiliations
#
#  id                          :integer          not null, primary key
#  participant_id              :integer
#  chapter_id                  :integer
#  recorded_attendance_count   :integer          default(0)
#  recorded_host_count         :integer          default(0)
#  recorded_since              :date
#  unrecorded_attendance_count :integer          default(0)
#  unrecorded_host_count       :integer          default(0)
#  attendance_count            :integer          default(0)
#  host_count                  :integer          default(0)
#  created_at                  :datetime
#  updated_at                  :datetime
#

class Affiliation < ActiveRecord::Base
	belongs_to :chapter
	belongs_to :participant
end
