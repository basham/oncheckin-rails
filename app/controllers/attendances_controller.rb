class AttendancesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def show
    render json: Attendance.find(params[:id]), serializer: AttendanceSerializer
  end

  def update
    a = Attendance.find(params[:id])
    # Toggle the hosting status of an attendance
    a.host(params[:host].to_bool)
    a.save
    render json: a, serializer: AttendanceSerializer
  end

  def destroy
    Attendance.delete(params[:id])
    render json: {}
  end

end