class LoadData2 < ActiveRecord::Migration
  def up
    # Create initial user.
    down

	sg = User.new(:name => "Stephanie Guo")
    sg.save(:validate => false)
    
    # Create initial listing
    
    listing1 = Listing.new(:name => "Eat with Stephanie",
        :category => "Eat", :city => "San Francisco", :description => "Let Stephanie take you on a whirlwind tour of San Francisco's best restaurants!")
    listing1.user = sg
    listing1.save(:validate => false)


    a = User.new(:name => "Erika Ji")
    a.save(:validate => false)

    b = User.new(:name => "Vivian Shen")
    b.save(:validate => false)

    c = User.new(:name => "Sterling Archer")
    c.save(:validate => false)
    
    # Create initial listing
    
    listing = Listing.new(:name => "Hike with Vivian",
        :category => "Outdoors", :city => "San Francisco", :description => "Go hiking with Vivian in SF!")
    listing.user = b
    listing.save(:validate => false)

    listing2 = Listing.new(:name => "Sightseeing with Erika",
        :category => "Sightseeing", :city => "New York", :description => "Go sightseeing with Erika in NY!")
    listing2.user = a
    listing2.save(:validate => false)

    listing3 = Listing.new(:name => "Nightlife with Archer",
        :category => "Nightlife", :city => "New York", :description => "Experience NY's nightlife with Archer!")
    listing3.user = c
    listing3.save(:validate => false)


  end

  def down
      Listing.delete_all
      User.delete_all
  end
end
