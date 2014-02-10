class UserController < ApplicationController
	def dashboard
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	end

  	def inbox
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	end

  	def listings
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	end
end
