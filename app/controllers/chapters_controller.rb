class ChaptersController < ApplicationController

	def index
		render json: Chapter.all
	end

	def show
		render json: Chapter.find(params[:id])
		#render json: Chapter.find(params[:id]).events.first.hares
	end

end
