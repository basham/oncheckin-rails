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

  def host value
    if value
      tag_list.add('host')
    else
      tag_list.remove('host')
    end
  end

  def host?
    tag_list.include? 'host'
  end

  def affiliation
    participant.affiliations.where(chapter_id: event.chapter_id).first
  end

  def calculate_affiliation_counts
    affiliation.calculate_counts
  end
end
