class AddListingToReviews < ActiveRecord::Migration
  def change
  	add_column :reviews, :listing, :integer
  end
end
