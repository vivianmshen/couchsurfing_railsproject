class ListingsController < ApplicationController
  def index
  	@users = User.all
  end

  def sanfrancisco
  	@categories = Listing.find_all_by_city('San Francisco')
  end

  def user
  	@user = User.find(params[:id])
  end

  def listing

  end
  
  def newyork
  	@categories = Listing.find_all_by_city('New York')
  end

end
