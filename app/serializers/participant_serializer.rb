class ParticipantSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :full_name, :alias, :attendance_count, :host_count
end