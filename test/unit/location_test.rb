require 'test_helper'

class LocationTest < ActiveSupport::TestCase
	should belong_to(:host)
	should have_many(:parties)
	
	should validate_presence_of :name
	should validate_presence_of :host_id
	
	should allow_value("Grandma's Lake House").for(:name)
	
	context "A new location" do
	
    setup do
	@host=Factory.create(:host)
	@location=Factory.create(:location, :host => @host)
	end
	
	teardown do
	@host.destroy
	@location.destroy
    end
	
	should "has a name" do
    assert_equal "My House", @location.name
	end
	
	should "has a street" do
	assert_equal "55 Rathbun Road", @location.street
	end
	
	should "has a city" do
	assert_equal "Natick", @location.city
	end
	
	should "has a state" do
	assert_equal "MA", @location.state
	end
	
	should "has a zip" do
	assert_equal "01760", @location.zip
	end
	
	should "test that the address method works" do
	assert_equal "55 Rathbun Road,Natick,MA", @location.address
	end
	
  end
end
