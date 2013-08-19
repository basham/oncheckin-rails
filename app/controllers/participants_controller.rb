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
    a = p.affiliations.create(chapter_id: params[:chapter_id])
    # if params.has_key?(:chapter_id)
    render json: p, serializer: ParticipantSerializer
  end

  def update
    Participant.find(params[:id]).attendances.create(event_id: params[:event_id]) if params[:event_id]
    render json: p, serializer: ParticipantSerializer
  end

  private

    def participant_params
      params.require(:participant).permit(:first_name, :last_name, :alias)
    end

end