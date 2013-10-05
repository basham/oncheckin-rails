class EventChapterSerializer < ActiveModel::Serializer
  attributes :id, :name
end

class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_time, :end_time, :description, :notes, :attendance_count, :host_count, :guest_count, :chapter, :tags, :attendances
  has_one :chapter, serializer: EventChapterSerializer
  has_many :attendances, serializer: AttendanceSerializer

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
end