class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :name
      t.string :category
      t.string :city
      t.text   :description
      t.integer :user_id
      t.timestamps
    end
  end
end
