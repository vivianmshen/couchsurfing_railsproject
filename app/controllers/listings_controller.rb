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
      @city = "San Francisco"
    elsif params[:city] == "ny"
      @city = "New York"
    end
    @listings = Listing.find_all_by_city(@city)
    @categories = Listing.find_all_by_city(@city)
  end

  def category
    if params[:city] == "sf"
      @city = "San Francisco"
    elsif params[:city] == "ny"
      @city = "New York"
    end
    @listings = Listing.find_all_by_city(@city)
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

  def create
    @listing = Listing.new
    @users = User.all
  end
  
  def post_create
    @listing = Listing.new
    @listing.name = params[:listing][:name]
    @listing.description = params[:listing][:description]
    @listing.city = params[:listing][:city]
    @listing.category =params[:listing][:category]
    @listing.user = User.find(params[:listing][:user_id])
    @listing.save()
    flash[:notice] = "Listing added successfully."
    redirect_to :action => :create
  end

end
