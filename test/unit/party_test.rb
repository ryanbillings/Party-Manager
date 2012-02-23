require 'test_helper'
require 'chronic'
class PartyTest < ActiveSupport::TestCase
  # Relationship macros...
  should belong_to(:host)
  should have_many(:guests)
  should belong_to(:location)
  should belong_to(:party_type)
  should have_many(:invitations)

  should validate_presence_of :date
  should validate_presence_of(:name)
  should validate_presence_of(:host_id)
  should validate_presence_of(:party_type_id)
  should validate_presence_of(:location_id)
  should validate_presence_of(:start_time)
  should validate_presence_of(:end_time)
  should validate_presence_of(:rsvp_date)
  
  should allow_value("Ryan's Graduation Party!").for(:name)
  should allow_value("6:53").for(:start_time)
  #should_not allow_value("12/3/2011/3").for(:rsvp_date)
  #should_not allow_value("5/3/2011/5").for(:date)
  
  context "A new party" do
    # create the object I want with a factory with 'setup' method
	
    setup do
      @host = Factory.create(:host)
	  @location = Factory.create(:location, :host=>@host)
	  @party_type = Factory.create(:party_type)
      @party = Factory.create(:party, :host => @host, :location => @location, :party_type => @party_type)
    end

    teardown do
	  @party.destroy	  
      @host.destroy
	  @location.destroy
	  @party_type.destroy    
    end

    should "has a name" do
      assert_equal "Graduation Party", @party.name
    end

    should "have a date" do
      assert_equal Chronic.parse("05/05/2011").to_date,
      @party.date
    end

    should "have a rsvp date" do
      assert_equal Chronic.parse("05/03/2011").to_date,
      @party.rsvp_date
    end
    should "have a start time" do
      assert_equal "12:00 PM", @party.start_time.strftime("%I:%M %p")
    end

    should "have a end time" do
      assert_equal "03:00 PM", @party.end_time.strftime("%I:%M %p")
    end

    should "shows that time method works" do
        assert_equal "12:00PM - 03:00PM", @party.time
    end
  end
end
