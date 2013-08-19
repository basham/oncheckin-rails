class ParticipantAffiliationsSerializer < ActiveModel::Serializer
  attributes :id, :name, :location,
    :attendance_count, :host_count,
    :recorded_attendance_count, :recorded_host_count,
    :unrecorded_attendance_count, :unrecorded_host_count

  def id
    object.chapter.id
  end

  def name
    object.chapter.name
  end

  def location
    object.chapter.location
  end
end

class ParticipantChaptersSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :full_name, :alias, :attendance_count, :host_count
  has_many :affiliations, key: :chapters, serializer: ParticipantAffiliationsSerializer
end