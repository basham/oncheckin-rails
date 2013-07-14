# == Schema Information
#
# Table name: affiliations
#
#  id                          :integer          not null, primary key
#  hasher_id                   :integer
#  kennel_id                   :integer
#  recorded_attendance_count   :integer
#  recorded_hare_count         :integer
#  recorded_since              :date
#  unrecorded_attendance_count :integer
#  unrecorded_hare_count       :integer
#  attendance_count            :integer
#  hare_count                  :integer
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
