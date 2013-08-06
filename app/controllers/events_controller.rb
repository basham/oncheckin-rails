class EventsController < ApplicationController

	def index
		# Chapter events
		return render json: Chapter.find(params[:chapter_id]).events, each_serializer: ChapterEventsSerializer if params.has_key?(:chapter_id)
		# Participant events
		return render json: Participant.find(params[:participant_id]).events if params.has_key?(:participant_id)
	end

	def show
		render json: Event.find(params[:id]), serializer: EventSerializer
	end

end
