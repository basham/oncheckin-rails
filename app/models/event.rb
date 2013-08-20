# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  chapter_id  :integer
#  name        :string(255)
#  start_time  :datetime
#  end_time    :datetime
#  description :text
#  notes       :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Event < ActiveRecord::Base
  belongs_to :chapter
  has_many :attendances
  has_many :participants, through: :attendances

  def hosts
    # Nested `attendence > participant` model
    attendances.includes(:participant).tagged_with('host')
  end
end
