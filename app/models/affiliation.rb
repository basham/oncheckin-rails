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

  after_create :calculate_counts

  def calculate_counts
    # Preload queries
    attended_events = participant.events.where(chapter_id: chapter_id)
    hosts = participant.hosts_by_chapter_id(chapter_id)

    if recorded_since.nil?
      # Unrecorded counts don't matter if we don't have a `since` date
      self.unrecorded_attendance_count = 0
      self.unrecorded_host_count = 0

      # Without unrecorded counts, these are easy
      self.attendance_count = attended_events.count
      self.host_count = hosts.count
    else
      # Events since the recording date
      future_attendance_count = attended_events.where('start_time > ?', recorded_since).count
      future_host_count = hosts.where('events.start_time > ?', recorded_since).count

      # All past events, which should already be included in the recorded counters,
      # assuming those records are correct
      past_attendance_count = attended_events.count - future_attendance_count
      past_host_count = hosts.count - future_host_count

      # Best guesses, accomodating events not yet in the database
      self.unrecorded_attendance_count = recorded_attendance_count - past_attendance_count
      self.unrecorded_host_count = recorded_host_count - past_host_count

      # Actual, live counts
      self.attendance_count = recorded_attendance_count + future_attendance_count
      self.host_count = recorded_host_count + future_host_count
    end

    save
  end
end
