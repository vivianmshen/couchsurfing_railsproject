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
    w = params[:w]
    h = params[:h]
    x_offset = params[:x1]
    y_offset = params[:y1]

    require 'open-uri'
    if File.exist?(Rails.root.join('app', 'assets', 'images', @current_user.photo))
      img = MiniMagick::Image.open(Rails.root.join('app', 'assets', 'images', @current_user.photo))
      img.resize('800x500')
      img.crop("#{w}x#{h}+#{200}+#{200}") #BUGGY OFFSET
      img.write(Rails.root.join('app', 'assets', 'images', @current_user.uid + '.jpg'))
      img
      submission_hash = {"photo" => @current_user.uid + '.jpg'}
      @current_user.update_attributes(submission_hash)
    end

    redirect_to :controller => :user, :action => :profile
  end

end
