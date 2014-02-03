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
