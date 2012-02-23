# GIVENS

Given /^an existing guest with the following data:$/ do |table|
  # table is a Cucumber::Ast::Table, i.e.,
  # Given I have:
  #   | a | b |
  #   | c | d |
  data = table.raw  # stores [['a', 'b'], ['c', 'd']] in the data variable
  attributes = Hash.new # make a hash to store the attributes
  data.each do |k,v| 
    attributes[k] = v
  end
  @guest = @grad.guests.create!(attributes)
end

Given /^an existing artis family guest$/ do
  @artis = Factory.create(:guest, :host => @an)
end
