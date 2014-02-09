class SessionsController < ApplicationController
  def new
  end

  def create
  	auth_hash = request.env['omniauth.auth']
  	user = User.from_omniauth(env["omniauth.auth"])
  	session[:user_id] = user.id
  	redirect_to :controller => :listings, :action => :index 
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to :controller => :listings, :action => :index
  end
end
