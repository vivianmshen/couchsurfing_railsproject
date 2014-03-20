class ListingsController < ApplicationController

  def index
  	@users = User.all
  end

  def explore
    @categories = ['Eat', 'Outdoors', 'Nightlife', 'Sightseeing']
  end

  def post_explore
    @listings = ['Eat', 'Outdoors', 'Nightlife', 'Sightseeing']

    if params[:checkboxes].present?
      @listings = params[:checkboxes]
    end

    flash[:categorylist] = @listings
    flash[:date] = params[:dates]
    redirect_to :controller => :listings, :action => :explore_listings
  end

  def explore_listings
    @val = flash[:date]
    if @val.present?
      @date = "%" + @val + "%"
      @listings = Listing.where("category IN (?) AND dates like (?)", flash[:categorylist], @date)
    else
      @listings = Listing.where("category IN (?)", flash[:categorylist])
    end
  end

  def user
  	@user = User.find(params[:id])
    @listings = User.find(params[:id]).listings
  end

  def listing
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

  def req
    
  end

  def post_req
    #alert("We've received your request, we'll work on it as soon as possible!");
    redirect_to :controller => :listings, :action => :index
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

  def delete
    Listing.find(params[:listing]).destroy
    redirect_to :controller => :user, :action => :listings
  end

  def edit
    @listing = Listing.find(params[:listing])
  end

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
                       "city" => params[:city],
                       "address" => params[:address],
                       "category" => params[:category]}
      @listing.update_attributes(submission_hash)
      redirect_to :action => :listing, :id => @listing.id
    end
  end

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

  def create
    @listing = Listing.new
    @users = User.all
    @currentuser = User.find(session[:user_id]).id
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
