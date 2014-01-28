class ListingsController < ApplicationController
  def index
  	@users = Listing.all
  end

  def sanfrancisco
  	
  end
end
