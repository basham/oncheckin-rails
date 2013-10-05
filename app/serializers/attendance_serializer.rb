class AttendanceParticipantSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :full_name, :alias
end

class AttendanceSerializer < ActiveModel::Serializer
  attributes :id, :host, :tag_ids, :participant
  has_one :participant, serializer: AttendanceParticipantSerializer
  has_many :tags#, embed: :ids

  def host
    object.host?
  end

  def tags
    object.tag_list - ['host']
  end
end