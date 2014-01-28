class ListingsController < ApplicationController
  def index
  	@users = Listing.all
  end

  def sanfrancisco
  	@categories = Listing.find_all_by_city('San Francisco')
  end

  def newyork
  	@categories = Listing.find_all_by_city('New York')
  end

end
