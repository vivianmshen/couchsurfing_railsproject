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

  def photo
    @city = "sf"
  end

  def post_photo
    picture = params[:photo]
    if picture == nil
      flash[:notice] = "Please enter a valid photo name."
      redirect_to :action => :photo
    else
      file = File.new(Rails.root.join('app', 'assets', 'images', picture.original_filename), 'wb')
      file.write(picture.read)
      #Listing.new = Listing.find(params[:id])
      redirect_to :action => :listing, :id => params[:id]
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

  def create
    if session[:user_id].nil?
      @listing = Listing.new
      @users = User.all
    else
      flash[:notice] = "Please login before adding comments."
      #link_to "Sign in with Facebook", "/auth/facebook", id: "sign_in" 
      redirect_to "/auth/facebook"
    end
  end
  
  def post_create
    picture = params[:photo]
    if picture == nil
      flash[:notice] = "Please enter a valid photo name."
      redirect_to :action => :create
    else
      file = File.new(Rails.root.join('app', 'assets', 'images', picture.original_filename), 'wb')
      file.write(picture.read)
      @listing = Listing.new
      @listing.name = params[:name]
      @listing.description = params[:description]
      @listing.city = params[:city]
      @listing.category =params[:category]
      @listing.user = User.find(params[:user_id])
      @listing.photo = picture.original_filename
      @listing.save()
      flash[:notice] = "Listing added successfully."
      params[:id] = @listing.id
      redirect_to :action => :listing
    end
  end

end
