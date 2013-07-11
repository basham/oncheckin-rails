# == Schema Information
#
# Table name: hashers
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  hash_name  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Hasher < ActiveRecord::Base
	has_many :affiliations
	has_many :kennels, through: :affiliations
	has_many :attendances
	has_many :events, through: :attendances

	def serializable_hash(options={})
		default = { except: [:created_at, :updated_at] }
		options = options.merge(default) { |k, x, y| x + y }
		hash = super options

		hash[:affiliation_count] = affiliations.count
		hash[:attendance_count] = attendances.count
		hash[:hare_count] = hares.count

		hash[:affiliations] = affiliations.map do |a|
			a.serializable_hash({
				except: [:hasher_id, :kennel_id],
				include: {
					kennel: { only: [:id, :name] }
				}
			})
		end

		hash[:attendances] = attendances.map do |a|
			a.serializable_hash({
				except: [:hasher_id],
				include: {
					event: { only: [:id, :name, :start_time] },
					kennel: { only: [:id, :name] }
				}
			})
		end

		hash
	end

	def hares
		attendances.tagged_with('hare')
	end

	def hares_by_kennel(kennel_id)
		hares.includes(:event).where(events: { kennel_id: kennel_id })
	end
end
