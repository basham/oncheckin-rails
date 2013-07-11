class EventsController < ApplicationController

	def index
		# Kennel events
		return render json: Kennel.find(params[:kennel_id]).events if params.has_key?(:kennel_id)
		# Hasher events
		return render json: Hasher.find(params[:hasher_id]).events if params.has_key?(:hasher_id)
	end

end
