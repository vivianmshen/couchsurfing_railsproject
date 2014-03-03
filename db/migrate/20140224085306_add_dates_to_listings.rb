class AddDatesToListings < ActiveRecord::Migration
  def change
    add_column :listings, :dates, :text
  end
end
