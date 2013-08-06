class ChapterSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :timezone, :url, :description, :event_count, :participant_count

  def event_count
  	object.events.count
  end

  def participant_count
  	object.participants.count
  end
end
