# == Schema Information
#
# Table name: participants
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  alias      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Participant < ActiveRecord::Base
  has_many :affiliations
  has_many :chapters, through: :affiliations
  has_many :attendances
  has_many :events, through: :attendances

  scope :match, lambda { |query|
    q = "%#{query}%"
    where('first_name LIKE ? OR last_name LIKE ? OR alias LIKE ?', q, q, q)
  }

  def full_name
    ([first_name, last_name] - ['', nil]).join(' ')
  end

  def full_name_reverse
    ([last_name, first_name] - ['', nil]).join(', ')
  end

  def attendance_count
    affiliations.sum(:attendance_count)
  end

  def hosts
    attendances.tagged_with('host')
  end

  def host_count
    affiliations.sum(:host_count)
  end

  def hosts_by_chapter_id(chapter_id)
    hosts.includes(:event).where(events: { chapter_id: chapter_id })
  end
end
