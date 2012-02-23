require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
 
 	#Relationships
	should belong_to(:party)
	should belong_to(:guest)
	should have_many(:gifts)
	should have_one(:host).through(:guest)
	
	should validate_presence_of :expected_attendees
	should validate_presence_of :host_id
	should validate_presence_of :party_id
	should validate_presence_of :guest_id
	
	should validate_numericality_of :expected_attendees
	
	should allow_value(5).for(:expected_attendees)
	should allow_value(5).for(:actual_attendees)
	should_not allow_value("Hello, World!").for(:expected_attendees)
	should_not allow_value("Hello, World!").for(:actual_attendees)
	should_not allow_value(-1).for(:expected_attendees)
	should_not allow_value(-1).for(:actual_attendees)
	should allow_value(nil).for(:actual_attendees)
	
	context "a new invitation" do
	
	setup do
	  @host = Factory.create(:host)
	  @location = Factory.create(:location, :host=>@host)
	  @party_type = Factory.create(:party_type)
      @party = Factory.create(:party, :host => @host, :location => @location, :party_type => @party_type)
	  @guest = Factory.create(:guest, :host => @host)
	  @invitation = Factory.create(:invitation, :guest => @guest, :host_id => @guest, :party => @party, :expected_attendees => 5)
	end
	
	teardown do
		@host.destroy
		@guest.destroy
		@location.destroy
		@party_type.destroy
		@party.destroy
		@invitation.destroy
	end
	
	should "have expected attendees" do
		assert_equal 5, @invitation.expected_attendees
	end
	
	should "not have actual attendees yet" do
		assert_equal @invitation.actual_attendees, nil
	end
	
	
	should "test the invite code method" do
		assert_equal @invitation.generate_invite_code.length, 16
		code=@invitation.generate_invite_code
		assert_equal code.match(/^[\w]{16}$/)!=nil, true
	end
	
	end
end
