class ParticipantsController < ApplicationController

	def index
		render json: Participant.all
	end

	def show
		render json: Participant.find(params[:id])
	end

end
