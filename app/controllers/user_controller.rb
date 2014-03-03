class UserController < ApplicationController
	def dashboard
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	end

  	def inbox
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
      @emails = Email.find_all_by_receiver(@current_user)
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
      	else
      		submission_hash = {"email" => params[:email],
                       "bio" => params[:bio]}
      	end
		@current_user.update_attributes(submission_hash)
    	redirect_to :controller => :user, :action => :profile
  	end

    def email
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def post_email
      @email = Email.new
      @email.subject = params[:subject]
      @email.body = params[:body]
      @email.sender = User.find(params[:sender]).id
      @email.receiver = params[:receiver]
      @email.save()
      flash[:notice] = "Email sent successfully."
      if params[:linkedfrom] == 'listing'
        redirect_to :controller => :listings, :action => :listing, :id => params[:listing]
      else
        redirect_to :controller => :user, :action => :inbox
      end
    end

    def thread
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
      @emails = Email.all
    end

end
