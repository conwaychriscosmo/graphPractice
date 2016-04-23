class WelcomeController < ApplicationController
	def data
		@data = WelcomeHelper.make_data
		render json: @data
	end
end
