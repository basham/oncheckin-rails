# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  kennel_id   :integer
#  name        :string(255)
#  start_time  :datetime
#  description :text
#  notes       :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Event < ActiveRecord::Base
	belongs_to :kennel
	has_many :attendances
	has_many :hashers, through: :attendances

	def hares
		# Only hashers
		#ids = attendances.tagged_with('hare').collect { |a| a.hasher_id }
		#Hasher.find( ids )

		# Nested `attendence > hasher` model
		attendances.includes(:hasher).tagged_with('hare')
	end

	def serializable_hash(options={})
		default = { except: [:created_at, :updated_at] }
		options = options.merge(default) { |k, x, y| x + y }
		super options
	end
end
