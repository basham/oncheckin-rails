class EventsController < ApplicationController
  skip_before_filter :verify_authenticity_token

	def index
		# Chapter events
		return render json: Chapter.find(params[:chapter_id]).events, each_serializer: ChapterEventsSerializer if params.has_key?(:chapter_id)
		# Participant events
		return render json: Participant.find(params[:participant_id]).events if params.has_key?(:participant_id)
	end

	def show
    return render json: Event.find(params[:id]), serializer: EventPrintSerializer if params[:format] == 'print'
		render json: Event.find(params[:id]), serializer: EventSerializer
	end

  def create
    e = Chapter.find(params[:chapter_id]).events.create(event_params)
    render json: e, serializer: EventSerializer
  end

  private

    def event_params
      params.require(:event).permit(:name, :description, :start_time, :end_time)
    end

end
