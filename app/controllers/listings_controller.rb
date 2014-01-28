class ListingsController < ApplicationController
  def index
  	@users = User.all
  end

  def sanfrancisco
  	
  end

  def user
  	@user = User.find(params[:id])
  end

  def listing

  end
  
end
