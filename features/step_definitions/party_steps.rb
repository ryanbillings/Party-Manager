# GIVENS

Given /^an existing party with the following data:$/ do |table|
  # table is a Cucumber::Ast::Table, i.e.,
  # Given I have:
  #   | a | b |
  #   | c | d |
  data = table.raw  # stores [['a', 'b'], ['c', 'd']] in the data variable
  attributes = Hash.new # make a hash to store the attributes
  data.each do |k,v| 
    attributes[k] = v
  end
  @party = @an.parties.create!(attributes)
end

Given /^an existing graduation party$/ do
  @grad = Factory.create(:party, :host => @an, :location => @home, :party_type => @grad_pt, :party_date => Time.parse("04/06/2011").to_date, :rsvp_date => nil)
  @daigles = Factory.create(:guest, :name => "Daigle Family", :host => @an)
  @daigle_invite = Factory.create(:invitation, :guest => @daigles, :party => @grad)
end

Given /^an existing birthday party$/ do
  @birthday = Factory.create(:party, :name => "Birthday!", :host => @an, :location => @home, :party_type => @birth_pt, :party_date => Time.parse("04/06/2011").to_date)
  @heimann_inivte = Factory.create(:invitation, :guest => @heimann, :party => @birthday, :expected_attendees => 4, :actual_attendees => 4)
  @phelps_invite = Factory.create(:invitation, :guest => @phelps, :party => @birthday, :expected_attendees => 4, :actual_attendees => 4)
  @quesenberry_invite = Factory.create(:invitation, :guest => @quesenberry, :party => @birthday, :expected_attendees => 3, :actual_attendees => 2)
  @sooriamurthi_invite = Factory.create(:invitation, :guest => @sooriamurthi, :party => @birthday, :expected_attendees => 4, :actual_attendees => 3)
  @weinberg_invite = Factory.create(:invitation, :guest => @weinberg, :party => @birthday, :expected_attendees => 2, :actual_attendees => nil)
  @blazevich_invite = Factory.create(:invitation, :guest => @blazevich, :party => @birthday)
  @young_invite = Factory.create(:invitation, :guest => @young, :party => @birthday, :actual_attendees => nil)
  # Expected = 27; Actual = 18; seven families invited; five responses and two no-response-yet
end

Given /^a guest is invited to the birthday party$/ do
  @reay_invite = Factory.create(:invitation, :guest => @reay, :party => @birthday, :expected_attendees => 6, :actual_attendees => nil)
end

Given /^another host with parties$/ do
  @bluto = Factory.create(:host, :first_name => "John", :last_name => "Blutarsky")
  @animal_house = Factory.create(:location, :host => @bluto, :name => "Animal House")
  @frat = Factory.create(:party_type, :name => "Frat Party")
  @otter = Factory.create(:guest, :host => @bluto, :name => "Eric Stratton and Guests", :email => "otter@example.com")
  @boon = Factory.create(:guest, :host => @bluto, :name => "Schoenstein Family", :email => "boon@example.com")
  @pinto = Factory.create(:guest, :host => @bluto, :name => "Kroger Family", :email => "pinto@example.com")
  @toga = Factory.create(:party, :name => "Toga Party", :host => @bluto, :location => @animal_house, :party_type => @frat)
  @otter_invite = Factory.create(:invitation, :guest => @otter, :party => @toga, :expected_attendees => 2, :actual_attendees => nil)
  @boon_invite = Factory.create(:invitation, :guest => @boon, :party => @toga, :expected_attendees => 4, :actual_attendees => 3)
  @pinto_invite = Factory.create(:invitation, :guest => @pinto, :party => @toga)
end