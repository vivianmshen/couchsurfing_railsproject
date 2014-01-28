class LoadData < ActiveRecord::Migration
  def up
    # Create initial user.
    down
    sg = User.new(:name => "Stephanie Guo")
    sg.save(:validate => false)
    
    # Create initial listing
    
    listing = Listing.new(:name => "Eat with Stephanie",
        :category => "Eat", :city => "San Francisco", :description => "Let Stephanie take you on a whirlwind tour of San Francisco's best restaurants!")
    listing.user = sg
    listing.save(:validate => false)


  end

  def down
      Listing.delete_all
      User.delete_all
  end
end