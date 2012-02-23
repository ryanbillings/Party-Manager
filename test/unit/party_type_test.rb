require 'test_helper'

class PartyTypeTest < ActiveSupport::TestCase
 
 should have_many(:parties)
 
 should allow_value("Super").for(:name)
 
 context "a new party type" do
 
 setup do
 @pt=Factory.create(:party_type)
 end
 
 teardown do
 @pt.destroy
 end
 
 should "have a name" do
 assert_equal "Graduation", @pt.name
 end
 
 end
end
