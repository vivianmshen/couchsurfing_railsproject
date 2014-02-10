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
    @user = @listing.user
    @email = @user.email
    @reviews = Review.find_all_by_listing(params[:id])
  end

  def city
    if !session[:user_id].nil?
      if params[:city] == "sf"
        @city = "San Francisco"
      elsif params[:city] == "ny"
        @city = "New York"
      end
      @listings = Listing.find_all_by_city(@city)
      @categories ||= Array.new
      @listings.each do |l|
        if(!@categories.include?(l.category))
          @categories.push(l.category)
        end
      end
    else
      redirect_to :controller => :user, :action => :login
    end
  end

  def category
    if params[:city] == "sf"
      @city = "San Francisco"
    elsif params[:city] == "ny"
      @city = "New York"
    end
    @listings = Listing.find_all_by_city(@city)
  end

  def review
    @users = User.all
    @review = Review.new
  end

  def post_review
    @review = Review.new
    @review.title = "asdf"
    @review.description = params[:description]
    @review.name = params[:name]
    #@review.user_id = User.find(params[:user_id])
    @review.user_id = User.find(session[:user_id]).id
    @review.rating = params[:rating]
    @review.listing = params[:listing]
    @review.save()
    flash[:notice] = "Review added successfully."
    redirect_to :action => :listing, :id => params[:listing]
   
  end

  def delete
    Listing.find(params[:listing]).destroy
    redirect_to :controller => :user, :action => :listings
  end

  def edit
    @listing = Listing.find(params[:listing])
  end

  def update
    @listing = Listing.find(params[:listing])
    submission_hash = {"name" => params[:name],
                       "description" => params[:description],
                       "city" => params[:city],
                       "category" => params[:category]}

 
    @listing.update_attributes(submission_hash)
    redirect_to :controller => :user, :action => :listings
  end

  def create
    @listing = Listing.new
    @users = User.all
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
      @listing.user = User.find(session[:user_id])
      @listing.photo = picture.original_filename
      @listing.save()
      flash[:notice] = "Listing added successfully."
      listing_id = @listing.id
      redirect_to :action => :listing, :id => listing_id
    end
  end

end
