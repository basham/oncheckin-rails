class KennelsController < ApplicationController

	def index
		render json: Kennel.all
	end

	def show
		render json: Kennel.find(params[:id])
		#render json: Kennel.find(params[:id]).events.first.hares
	end

end
