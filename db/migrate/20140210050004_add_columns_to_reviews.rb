class AddColumnsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :title, :string
    add_column :reviews, :name, :string
    add_column :reviews, :user_id, :integer
    add_column :reviews, :rating, :decimal
    add_column :reviews, :description, :text
  end
end
