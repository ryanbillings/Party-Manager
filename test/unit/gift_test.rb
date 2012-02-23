require 'test_helper'

class GiftTest < ActiveSupport::TestCase
  
  
  should belong_to(:invitation)
  should validate_presence_of :description
  should validate_presence_of :invitation_id
  
  should allow_value("Thank you so much for ___________").for(:description)
  
  context "a new gift" do
  
    setup do
	  @host = Factory.create(:host)
	  @location = Factory.create(:location, :host=>@host)
	  @party_type = Factory.create(:party_type)
      @party = Factory.create(:party, :host => @host, :location => @location, :party_type => @party_type)
	  @guest = Factory.create(:guest, :host => @host)
	  @invitation = Factory.create(:invitation, :guest => @guest, :host_id => @guest, :party => @party)
	  @gift = Factory.create(:gift, :invitation => @invitation)
	end
	
	teardown do
		@host.destroy
		@guest.destroy
		@location.destroy
		@party_type.destroy
		@party.destroy
		@invitation.destroy
		@gift.destroy
	end
	
	should "have a description" do
		assert_equal "Thank you so much for the $50 coupon to best buy", @gift.description
	end
	
	should "be sent today" do
		assert_equal 1.week.from_now.strftime("%B %d, %Y"), @gift.note_sent_on.strftime("%B %d, %Y")
	end
	end
end
