class HashersController < ApplicationController

	def index
		render json: Hasher.all
	end

	def show
		render json: Hasher.find(params[:id])
	end

end
