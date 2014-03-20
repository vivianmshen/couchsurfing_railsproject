class ListingsController < ApplicationController

  #Index page (home)
  def index
  	@users = User.all
  end

  #Explore page
  def explore
    @categories = ['Eat', 'Outdoors', 'Nightlife', 'Sightseeing']
  end

  #Post explore filtering
  def post_explore
    @listings = ['Eat', 'Outdoors', 'Nightlife', 'Sightseeing']

    if params[:checkboxes].present?
      @listings = params[:checkboxes]
    end

    flash[:categorylist] = @listings
    flash[:date] = params[:dates]
    redirect_to :controller => :listings, :action => :explore_listings
  end

  #Filtered results display after the post
  def explore_listings
    @val = flash[:date]
    if @val.present?
      @date = "%" + @val + "%"
      @listings = Listing.where("category IN (?) AND dates like (?)", flash[:categorylist], @date)
    else
      @listings = Listing.where("category IN (?)", flash[:categorylist])
    end
  end

  #Show and individual user page
  def user
  	@user = User.find(params[:id])
    @listings = User.find(params[:id]).listings
  end

  #Show an individual listing
  def listing
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @listing = Listing.find(params[:id])
    @address = @listing.address
    @user = @listing.user
    @email = @user.email
    @dates = @listing.dates
    @reviews = Review.find_all_by_listing(params[:id])
    if @reviews.length == 0 
      @average = -1
    else
      @sum = 0
      @count = 0
      @reviews.each do |r|
        @sum += r.rating
        @count += 1
      end
      @average = @sum / @count
    end
    
  end

  #Displays the city page, which has all the listings for a city
  def city
    if !session[:user_id].nil?
      if params[:city] == "new"
        redirect_to :controller => :listings, :action => :req
      else
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
      end
    else
      redirect_to :controller => :user, :action => :login
    end
  end

  #Submit a req for a new city
  def req
    
  end

  #Post submission of a request for a new city
  def post_req
    redirect_to :controller => :listings, :action => :index
  end

  #Shows the listings under a category for a city
  def category
    if params[:city] == "sf"
      @city = "San Francisco"
    elsif params[:city] == "ny"
      @city = "New York"
    end
    @listings = Listing.find_all_by_city(@city)
  end

  #Page to submit a review for a listing
  def review
    @users = User.all
    @review = Review.new
  end

  #Post submission of a review for a listing
  def post_review
    @review = Review.new
    @review.title = params[:title]
    @review.description = params[:description]
    @review.name = params[:name]
    @review.user_id = User.find(session[:user_id]).id
    @review.rating = params[:rating]
    @review.listing = params[:listing]
    @review.save()
    # flash[:notice] = "Review added successfully."
    redirect_to :action => :listing, :id => params[:listing]
  end

  #Delete a listing
  def delete
    Listing.find(params[:listing]).destroy
    redirect_to :controller => :user, :action => :listings
  end

  #Edit a listing
  def edit
    @listing = Listing.find(params[:listing])
  end

  #Post edit, actually update a listing in the back
  def update
    @listing = Listing.find(params[:listing])
    picture = params[:photo]
    if picture != nil
      file = File.new(Rails.root.join('app', 'assets', 'images', picture.original_filename), 'wb')
      file.write(picture.read)
      submission_hash = {"name" => params[:name],
                       "description" => params[:description],
                       "dates" => params[:dates],
                       "city" => params[:city],
                       "category" => params[:category],
                       "address" => params[:address],
                       "photo" => picture.original_filename}
      @listing.update_attributes(submission_hash)
      render :action => 'crop' 
    else
      submission_hash = {"name" => params[:name],
                       "description" => params[:description],
                       "dates" => params[:dates],
                       "city" => params[:city],
                       "address" => params[:address],
                       "category" => params[:category]}
      @listing.update_attributes(submission_hash)
      redirect_to :action => :listing, :id => @listing.id
    end
  end

  #Post cropping
  def post_crop
    @listing = Listing.find(params[:listing])
    w = params[:w]
    h = params[:h]
    x1 = params[:x1]
    y1 = params[:y1]

    require 'open-uri'
    if File.exist?(Rails.root.join('app', 'assets', 'images', @listing.photo))
      img = MiniMagick::Image.open(Rails.root.join('app', 'assets', 'images', @listing.photo))
      img.resize('900x600')
      img.crop("#{w}x#{h}+#{x1}+#{y1}")
      img.write(Rails.root.join('app', 'assets', 'images', @listing.user_id.to_s + '_' + @listing.id.to_s + '.jpg'))
      img
      submission_hash = {"photo" => @listing.user_id.to_s + '_' + @listing.id.to_s + '.jpg'}
      @listing.update_attributes(submission_hash)
    end

    redirect_to :action => :listing, :id => @listing.id
  end

  #Create a new listing page
  def create
    @listing = Listing.new
    @users = User.all
    @currentuser = User.find(session[:user_id]).id
  end
  
  #Post creation, actually submitting data
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
      @listing.user = User.find(params[:currentuser].to_i)
      @listing.dates = params[:dates]
      @listing.photo = picture.original_filename
      @listing.address = params[:address]
      @listing.save()
      listing_id = @listing.id
      render :action => 'crop'
    end
  end

end
