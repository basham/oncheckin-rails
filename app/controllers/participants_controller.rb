class ParticipantsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    # Chapter participants
    render json: Chapter.find(params[:chapter_id]).participants.match(params[:query]),
      each_serializer: ChapterParticipantsSerializer if params.has_key?(:chapter_id)
  end

  def show
    render json: Participant.find(params[:id]), serializer: ParticipantChaptersSerializer
  end

  def create
    p = Participant.create(participant_params)
    a = p.affiliations.create(affiliation_params)
    # if params.has_key?(:chapter_id)
    render json: p, serializer: ParticipantSerializer
  end

  def update
    p = Participant.find(params[:id])
    p.attendances.create(event_id: params[:event_id]) if params[:event_id]
    render json: p, serializer: ParticipantSerializer
  end

  private

    def participant_params
      params.require(:participant).permit(:first_name, :last_name, :alias)
    end

    def affiliation_params
      params.require(:affiliation).permit(:chapter_id, :recorded_since, :recorded_attendance_count, :recorded_host_count)
    end

end