class EventChapterSerializer < ActiveModel::Serializer
  attributes :id, :name
end

class EventPrintParticipantSerializer < ActiveModel::Serializer
  attributes :id, :name, :alias

  def name
    object.full_name_reverse
  end
end

#class EventPrintLastAttendedEventSerializer < ActiveModel::Serializer
#  attributes :id, :name
#end

class EventPrintRowSerializer < ActiveModel::Serializer
  attributes :host, :attendance_count, :host_count, :last_attended_event_date#, :last_attended_event
  #has_one :last_attended_event, serializer: EventPrintLastAttendedEventSerializer
  has_one :participant, serializer: EventPrintParticipantSerializer

  def host
    return false if object.attendance.nil?
    object.attendance.host?
  end

  def attendance_count
    object.affiliation.attendance_count
  end

  def host_count
    object.affiliation.host_count
  end

  def last_attended_event
    participant.events.first
  end

  def last_attended_event_date
    return object.affiliation.recorded_since if last_attended_event.nil? || last_attended_event.start_time.nil?
    last_attended_event.start_time.to_date
  end

  def participant
    object.affiliation.participant
  end
end

class EventPrintRow
  attr_accessor :affiliation, :attendance
end

class EventPrintSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_time, :chapter
  has_one :chapter, serializer: EventChapterSerializer
  has_many :affiliations, serializer: EventPrintRowSerializer

  def tags
    Attendance.where(:event => object).tag_counts_on(:tags)
  end

  def attendance_count
    attendances.count
  end

  def host_count
    object.hosts.count
  end

  def guest_count
    attendance_count - host_count
  end

  def affiliations
    # TODO
    # Active within the last year
    affiliations = object.chapter.affiliations.order('attendance_count DESC')
    attendances = object.attendances

    # Merge attendance data with affiliations
    rows = affiliations.map do |a|
      row = EventPrintRow.new
      row.affiliation = a
      attendance = attendances.find { |b| b.participant.id == a.participant.id }
      row.attendance = attendance unless attendance.nil?
      row
    end

    rows
  end
end