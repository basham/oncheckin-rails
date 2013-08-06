class ParticipantsController < ApplicationController

	def index
		# Chapter participants
		return render json: Chapter.find(params[:chapter_id]).participants, each_serializer: ChapterParticipantsSerializer if params.has_key?(:chapter_id)

		render json: Participant.all
	end

	def show
		render json: Participant.find(params[:id])
	end

end
