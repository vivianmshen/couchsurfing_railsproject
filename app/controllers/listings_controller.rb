class ListingsController < ApplicationController
  def index
  	@users = User.all
  end

  def user
  	@user = User.find(params[:id])
    @listings = User.find(params[:id]).listings
  end

  def listing
    @listing = Listing.find(params[:id])
  end

  def city
    if params[:city] == "sf"
      @listings = Listing.find_all_by_city('San Francisco')
      @categories = Listing.find_all_by_city('San Francisco')
    elsif params[:city] == "ny"
      @listings = Listing.find_all_by_city('New York')
      @categories = Listing.find_all_by_city('New York')
    end
  end

  def category
    if params[:city] == "sf"
      @listings = Listing.find_all_by_city('San Francisco')
    elsif params[:city] == "ny"
      @listings = Listing.find_all_by_city('New York')
    end
  end

  #def sanfrancisco
  #  @listings = Listing.find_all_by_city('San Francisco')
  #  @categories = Listing.find_all_by_city('San Francisco')
  #  $city = "sf"
  #end

  #def newyork
  #  @listings = Listing.find_all_by_city('New York')
  #  @categories = Listing.find_all_by_city('New York')
  #  $city = "ny"
  #end

end
