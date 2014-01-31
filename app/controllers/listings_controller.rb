class ListingsController < ApplicationController
  def index
  	@users = User.all
  end

  def sanfrancisco
  	@categories = Listing.find_all_by_city('San Francisco')
    $city = "sf"
  end

  def user
  	@user = User.find(params[:id])
  end

  def listing
    @user = Listing.find(params[:id])
  end
  
  def newyork
  	@categories = Listing.find_all_by_city('New York')
    $city = "ny"
  end

  def category
    
    #@listings = Listing.find_all_by_city(params[])
  end

end
