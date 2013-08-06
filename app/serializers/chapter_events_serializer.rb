class ChapterEventsSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_time, :end_time, :description, :notes
end
