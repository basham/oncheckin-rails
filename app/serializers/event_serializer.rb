class EventChapterSerializer < ActiveModel::Serializer
	attributes :id, :name
end

class EventParticipantSerializer < ActiveModel::Serializer
	attributes :id, :first_name, :last_name, :full_name, :alias

	def full_name
		"#{first_name} #{last_name}"
	end
end

class EventAttendancesSerializer < ActiveModel::Serializer
	attributes :id, :host, :tag_ids, :participant
	has_one :participant, serializer: EventParticipantSerializer
	has_many :tags#, embed: :ids

	def host
		object.host?
	end
end

class EventSerializer < ActiveModel::Serializer
	attributes :id, :name, :start_time, :end_time, :description, :notes, :chapter, :tags, :attendances
	has_one :chapter, serializer: EventChapterSerializer
	has_many :attendances, serializer: EventAttendancesSerializer

	def tags
		Attendance.where(:event => object).tag_counts_on(:tags)
	end
end