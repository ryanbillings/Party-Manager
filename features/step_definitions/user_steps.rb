# GIVENS

Given /^a valid user$/ do
  # A host (my wife) ...
  @an = Factory.create(:host)
  # has some locations ...
  @home = Factory.create(:location, :host => @an)
  @park = Factory.create(:location, :host => @an, :name => "North Park", :street => "Pearce Mill Road", :city => "Allison Park", :zip => "15101")
  # and some guests ...
  @heimann = Factory.create(:guest, :host => @an, :name => "Heimann Family", :email => "heimann@example.com")
  @phelps = Factory.create(:guest, :host => @an, :name => "Phelps Family", :email => "phelps@example.com")
  @quesenberry = Factory.create(:guest, :host => @an, :name => "Quesenberry Family", :email => "quesenberry@example.com")
  @sooriamurthi = Factory.create(:guest, :host => @an, :name => "Sooriamurthi Family", :email => "sooriamurthi@example.com")
  @weinberg = Factory.create(:guest, :host => @an, :name => "Weinberg Family", :email => "weinberg@example.com")
  @blazevich = Factory.create(:guest, :host => @an, :name => "Blazevich Family", :email => "blazevich@example.com")
  @young = Factory.create(:guest, :host => @an, :name => "Young Family", :email => "young@example.com")
  @schell = Factory.create(:guest, :host => @an, :name => "Schell Family", :email => "seeschells@example.com")
  @reay = Factory.create(:guest, :host => @an, :name => "Reay Family", :email => "reay@example.com")
  
  
  # and there are some party types to choose from ...
  @gen_pt = Factory.create(:party_type)
  @birth_pt = Factory.create(:party_type, :name => "Birthday Party")
  @grad_pt = Factory.create(:party_type, :name => "Graduation Party")
  @frat_pt = Factory.create(:party_type, :name => "Fraternity Party")
end

Given /^a logged in user$/ do
  Given "a valid user"
  visit login_url
  fill_in "Username", :with => "an.heimann"
  fill_in "Password", :with => "fredbar"
  click_button "Log in"
end
