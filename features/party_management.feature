Feature: Manage parties
	As a party host
	I want to be able to manage parties online
	So I can reduce the overhead of hosting parties

	Background:
	  Given a logged in user
	
	# READ METHODS
	Scenario: View my parties
		When I go to my parties page
		Then I should see "My Parties" within "h1"
		And I should see "RSVPs"
		And I should not see "Start time"
		
	Scenario: View only my parties
		Given an existing birthday party
		Given another host with parties
		When I go to my parties page
		Then I should see "Birthday!"
		And I should not see "Toga Party"
	
	Scenario: View party details
		Given an existing graduation party
		When I go to the graduation party details page
		# OR ...
		# Given an existing party with the following data:
		# 		  | name        | Graduation Party |
		# 		  | party_date  | 2011-06-04       |
		# 		  | location_id | 1                |
		# 		  | start_time  | 12:00:00         |
		# 		  | end_time    | 15:00:00         |
		# 		When I go to this party details page
		Then I should see "No RSVP required"
		And I should see "Graduation Party"	
		And I should see "12:00 PM - 03:00 PM"
		And I should see "June 04, 2011"
	
	Scenario: Verify a party with no rsvp date doesn't show confirmed guests
		# existing graduation party includes Daigle guest factory with 5 actual attendees
		Given an existing graduation party
		When I go to the graduation party details page
		Then I should see "No RSVP required"
		And I should see "Graduation Party"	
		And I should see "12:00 PM - 03:00 PM"
		And I should see "Daigle Family"
		And I should not see "Actual attendees"
		And I should not see "Confirmed attendees"
	
	
	# CREATE METHODS
	Scenario: Create a new party is successful
		When I go to the new party page
		And I fill in "party_name" with "Birthday for Dusty"
		And I select "My house" from "party_location_id"
		And I select "Birthday Party" from "party_party_type_id"
		And I select "2011" from "party_party_date_1i"
		And I select "October" from "party_party_date_2i"
		And I select "27" from "party_party_date_3i"
		And I select "2011" from "party_rsvp_date_1i"
		And I select "October" from "party_rsvp_date_2i"
		And I select "26" from "party_rsvp_date_3i"
		And I select "18" from "party_start_time_4i"
		And I select "00" from "party_start_time_5i"
		And I select "22" from "party_end_time_4i"
		And I select "30" from "party_end_time_5i"
		And I press "Create Party"
		Then I should see "Birthday for Dusty"	
		And I should see "RSVP date: October 26, 2011"
		And I should see "06:00 PM - 10:30 PM"
		And I should see "Expected Attendance: 0"
		And I should see "Confirmed Attendance: 0"
		
	Scenario: Create a new party fails without a name
		When I go to the new party page
		And I select "My house" from "party_location_id"
		And I select "Birthday Party" from "party_party_type_id"
		And I select "2011" from "party_party_date_1i"
		And I select "October" from "party_party_date_2i"
		And I select "27" from "party_party_date_3i"
		And I select "2011" from "party_rsvp_date_1i"
		And I select "October" from "party_rsvp_date_2i"
		And I select "26" from "party_rsvp_date_3i"
		And I select "18" from "party_start_time_4i"
		And I select "00" from "party_start_time_5i"
		And I select "22" from "party_end_time_4i"
		And I select "30" from "party_end_time_5i"
		And I press "Create Party"
		Then I should see "Name can't be blank"	
	
	Scenario: Create a new party fails because date is in the past
		When I go to the new party page
		And I fill in "party_name" with "Birthday for Dusty"
		And I select "My house" from "party_location_id"
		And I select "Birthday Party" from "party_party_type_id"
		And I select "2011" from "party_party_date_1i"
		And I select "January" from "party_party_date_2i"
		And I select "27" from "party_party_date_3i"
		And I select "2011" from "party_rsvp_date_1i"
		And I select "January" from "party_rsvp_date_2i"
		And I select "26" from "party_rsvp_date_3i"
		And I select "18" from "party_start_time_4i"
		And I select "00" from "party_start_time_5i"
		And I select "22" from "party_end_time_4i"
		And I select "30" from "party_end_time_5i"
		And I press "Create Party"
		Then I should see "Party date must be on or after"
		
	Scenario: Create a new party fails because rsvp date after party date
		When I go to the new party page
		And I fill in "party_name" with "Birthday for Dusty"
		And I select "Birthday Party" from "party_party_type_id"
		And I select "My house" from "party_location_id" 
		And I select "2011" from "party_party_date_1i"
		And I select "October" from "party_party_date_2i"
		And I select "27" from "party_party_date_3i"
		And I select "2011" from "party_rsvp_date_1i"
		And I select "October" from "party_rsvp_date_2i"
		And I select "31" from "party_rsvp_date_3i"
		And I select "18" from "party_start_time_4i"
		And I select "00" from "party_start_time_5i"
		And I select "22" from "party_end_time_4i"
		And I select "30" from "party_end_time_5i"
		And I press "Create Party"
		Then I should see "Rsvp date must be on or before"
		
	Scenario: Create an invalid party with end time before start time
		When I go to the new party page
		And I fill in "party_name" with "Birthday for Dusty"
		And I select "Birthday Party" from "party_party_type_id"
		And I select "My house" from "party_location_id"
		And I select "2011" from "party_party_date_1i"
		And I select "October" from "party_party_date_2i"
		And I select "27" from "party_party_date_3i"
		And I select "2011" from "party_rsvp_date_1i"
		And I select "October" from "party_rsvp_date_2i"
		And I select "26" from "party_rsvp_date_3i"
		And I select "18" from "party_start_time_4i"
		And I select "00" from "party_start_time_5i"
		And I select "12" from "party_end_time_4i"
		And I select "30" from "party_end_time_5i"
		And I press "Create Party"
		Then I should see "End time must be after"

	Scenario: Create an invalid party with a missing party type
		When I go to the new party page
		And I fill in "party_name" with "Birthday for Dusty"
		And I select "My house" from "party_location_id"
		And I select "2011" from "party_party_date_1i"
		And I select "October" from "party_party_date_2i"
		And I select "27" from "party_party_date_3i"
		And I select "2011" from "party_rsvp_date_1i"
		And I select "October" from "party_rsvp_date_2i"
		And I select "26" from "party_rsvp_date_3i"
		And I select "18" from "party_start_time_4i"
		And I select "00" from "party_start_time_5i"
		And I select "22" from "party_end_time_4i"
		And I select "30" from "party_end_time_5i"
		And I press "Create Party"
		Then I should see "Party type is not a number"
		
		
	# UPDATE METHODS
	Scenario: Edit an upcoming party successfully
		# use the @grad factory for this one...
		Given an existing graduation party
		When I go to edit the graduation party
		And I fill in "party_name" with "Graduation for the Twins"
		And I press "Update Party"
		Then I should see "Graduation for the Twins"
		
	Scenario: Edit an upcoming party fails because name left blank
		# use the @grad factory for this one...
		Given an existing graduation party
		When I go to edit the graduation party
		And I fill in "party_name" with ""
		And I press "Update Party"
		Then I should see "Name can't be blank"
	
	Scenario: Edit an upcoming party fails because date is in the past
		# use the @grad factory for this one...
		Given an existing graduation party
		When I go to edit the graduation party
		And I select "2011" from "party_party_date_1i"
		And I select "January" from "party_party_date_2i"
		And I select "27" from "party_party_date_3i"
		And I press "Update Party"
		Then I should see "Party date must be on or after"
		
	Scenario: Edit an upcoming party fails because end time before start time
		# use the @grad factory for this one...
		Given an existing graduation party
		When I go to edit the graduation party
		And I select "18" from "party_start_time_4i"
		And I select "00" from "party_start_time_5i"
		And I select "12" from "party_end_time_4i"
		And I select "30" from "party_end_time_5i"
		And I press "Update Party"
		Then I should see "End time must be after"