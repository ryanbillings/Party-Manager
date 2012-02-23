require 'test_helper'

class GuestTest < ActiveSupport::TestCase
  #Relationships
  
	should belong_to(:host)
	should have_many(:invitations)
	should have_many(:gifts)
	
	should validate_presence_of :name
	should validate_presence_of :email
	should validate_presence_of :host_id
	
	should allow_value("Mr. Heimann").for(:name)
	should allow_value("example123@example.com").for(:email)
	should_not allow_value("heeeey").for(:email)
	
	context "A new guest" do
	
    setup do
	@host=Factory.create(:host)
	@ryan=Factory.create(:guest, :host => @host)
	end
	
	teardown do
	@host.destroy
	@ryan.destroy
    end
	
	should "has a name" do
    assert_equal "Billings Fam", @ryan.name
	end
	
	should "has an email" do
	assert_equal "ryj.billings@gmail.com", @ryan.email
	end
	
	
  end
end
