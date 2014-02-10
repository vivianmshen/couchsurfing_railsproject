class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
    	t.string :title
    	t.string :name
    	t.integer :user_id
    	t.decimal :rating
    	t.text :description
      	t.timestamps
    end
  end
end
