class ChapterParticipantsSerializer < ActiveModel::Serializer
	attributes :id, :first_name, :last_name, :full_name, :alias, :attendance_count, :host_count

	def chapter_id
		options[:url_options][:_recall][:chapter_id]
	end

	def chapter_affiliation
		object.affiliations.where(:chapter_id => chapter_id).first
	end

	def attendance_count
		chapter_affiliation.attendance_count
	end

	def host_count
		chapter_affiliation.host_count
	end
end
