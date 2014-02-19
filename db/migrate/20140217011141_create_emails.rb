class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
    	t.string :subject
		t.integer :receiver
		t.integer :sender
		t.text :body
		t.timestamps
    end
  end
end
