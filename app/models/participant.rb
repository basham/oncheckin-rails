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

class Participant < ActiveRecord::Base
	has_many :affiliations
	has_many :chapters, through: :affiliations
	has_many :attendances
	has_many :events, through: :attendances

	def serializable_hash(options={})
		default = { except: [:created_at, :updated_at] }
		options = options.merge(default) { |k, x, y| x + y }
		hash = super options

		hash[:affiliation_count] = affiliations.count
		hash[:attendance_count] = affiliations.sum(:attendance_count)
		hash[:host_count] = affiliations.sum(:host_count)

		hash[:affiliations] = affiliations.map do |a|
			a.serializable_hash({
				except: [:participant_id, :chapter_id],
				include: {
					chapter: { only: [:id, :name] }
				}
			})
		end

		hash[:attendances] = attendances.map do |a|
			a.serializable_hash({
				except: [:participant_id],
				include: {
					event: { only: [:id, :name, :start_time] },
					chapter: { only: [:id, :name] }
				}
			})
		end

		hash
	end

	def hosts
		attendances.tagged_with('host')
	end

	def hosts_by_chapter(chapter_id)
		hosts.includes(:event).where(events: { chapter_id: chapter_id })
	end
end
