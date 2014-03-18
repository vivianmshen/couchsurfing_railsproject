class UserController < ApplicationController
	def dashboard
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def inbox
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def listings
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
		@listings = Listing.find_all_by_user_id(@current_user)
	end

	def edit
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def update
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
		picture = params[:photo]

  	if picture != nil
    		file = File.new(Rails.root.join('app', 'assets', 'images', picture.original_filename), 'wb')
    		file.write(picture.read)
    		submission_hash = {"email" => params[:email],
                     "bio" => params[:bio],
                     "photo" => picture.original_filename}
        @current_user.update_attributes(submission_hash)
        render :action => 'crop'
    	else
    		submission_hash = {"email" => params[:email],
                     "bio" => params[:bio]}
        @current_user.update_attributes(submission_hash)
        redirect_to :controller => :user, :action => :profile
    	end

	end

  def post_crop
    
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    redirect_to :controller => :user, :action => :profile
  end

end
