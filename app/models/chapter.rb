# == Schema Information
#
# Table name: chapters
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  location    :string(255)
#  timezone    :string(255)
#  url         :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Chapter < ActiveRecord::Base
  has_many :events
  has_many :affiliations
  has_many :participants, through: :affiliations
end
