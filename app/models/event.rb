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
		# Only participants
		#ids = attendances.tagged_with('hare').collect { |a| a.participant_id }
		#Participant.find( ids )

		# Nested `attendence > participant` model
		attendances.includes(:participant).tagged_with('host')
	end

	#def serializable_hash(options={})
	#	default = { except: [:created_at, :updated_at] }
	#	options = options.merge(default) { |k, x, y| x + y }
	#	super options
	#end
end
