Feature: Manage locations
	As a party host
	I want to be able to manage locations
	So I can reduce the overhead of hosting parties

	Background:
	  Given a logged in user
		Given an existing birthday party

	# READ METHODS
	Scenario: View my locations
		When I go to my locations page
		Then I should see "My Locations" within "h1"
		And I should see "Name"
		And I should see "Street"
		And I should see "Add A New Location"
		And I should see "North Park"
		And I should see "My house"
		And I should see "10152 Sudberry Drive"
		And I should not see "Latitude"
		And I should not see "40.597761"
    And I should not see "longitude"
 		And I should not see "-80.063405"
		
	Scenario: View only my locations
		Given another host with parties
		When I go to my locations page
		Then I should see "North Park"
		And I should see "My house"
		And I should see "10152 Sudberry Drive"
		And I should not see "Animal House"
		
	Scenario: View location details
		Given an existing birthday party
		When I go to my house details page
		Then I should see "10152 Sudberry Drive"
		And I should not see "North Park"
		And I should see a map of home
    	
	# CREATE METHODS
	Scenario: Create a new location - no host field
	  When I go to the new location page
		Then I should not see host option
	
	Scenario: Create a new location - no latitude longitude fields
	  When I go to the new location page
		Then I should not see latitude longitude options
	
	Scenario: Creating a new location is successful
	  When I go to the new location page
		And I fill in "location_name" with "ACAC"
		And I fill in "location_street" with "250 East Ohio Street"
		And I fill in "location_city" with "Pittsburgh"
		And I fill in "location_state" with "PA"
		And I fill in "location_zip" with "15212"
		And I press "Create Location"
	  Then I should see "Location was successfully created"
		And I should see a map of ACAC

	
	