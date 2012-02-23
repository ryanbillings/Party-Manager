Feature: Manage invitations
	As a party host
	I want to be able to manage guest invitations
	So I can reduce the overhead of hosting parties

	Background:
	  Given a logged in user
		Given an existing birthday party
	
	# READ METHODS		
	Scenario: View my invitations
		When I go to my invitations page
		Then I should see "My Invitations" within "h1"
		And I should see "Party"
		And I should see "Guests"
		And I should see "Add A New Invitation"
		And I should see "Birthday!"
		And I should see "Heimann Family"
		And I should see "Phelps Family"
		And I should see "Quesenberry Family"
		
	Scenario: View only my invitations
		Given another host with parties
		When I go to my invitations page
		Then I should see "Heimann Family"
		And I should see "Phelps Family"
		And I should see "Quesenberry Family"
		And I should not see "Schoenstein Family"
		And I should not see "Kroger Family"
	
	Scenario: Counts on the party page are correct
		When I go to the birthday party details page
		Then I should see "Expected Attendance: 27"
		And I should see "Confirmed Attendance: 18"
		And I should see "Invited Guests"
		And I should see "Heimann Family"
		And I should see "Phelps Family"
		And I should see "Quesenberry Family"
		And I should see "Birthday!"

	# CREATE METHODS
	Scenario: Create a new invitation - no actual/confirmed attendees field
		When I go to the new invitation page
		Then I should not see actual attendees option

	Scenario: Create a new invitation - no invitation code field to be set
		When I go to the new invitation page
		Then I should not see invite code option
	
	Scenario: Create a new invitation is successful
		When I go to the new invitation page
		And I select "Schell Family" from "invitation_guest_id"
		And I select "Birthday!" from "invitation_party_id"
		And I fill in "invitation_expected_attendees" with "5"
		And I press "Create Invitation"
		Then I should see "Invitation was successfully created"
		And I should see "Birthday!"
		And I should see "Schell Family"
		And I should see "Invite code"
		And I should see "Expected attendees: 5"
		And I should not see "Actual attendees"
		And I should receive an email
		When I open the email with subject "Join the Party!"
		Then I should see "invite code" in the email body
			
	Scenario: Create a new invitation fails if no guest selected
	  When I go to the new invitation page
		And I select "Birthday!" from "invitation_party_id"
		And I fill in "invitation_expected_attendees" with "5"
		And I press "Create Invitation"
		Then I should see "Guest is not a number"
	
	Scenario: Create a new invitation fails if no expected guests entered
	  When I go to the new invitation page
		And I select "Schell Family" from "invitation_guest_id"
		And I select "Birthday!" from "invitation_party_id"
		And I press "Create Invitation"
		Then I should see "Expected attendees is not a number"

	Scenario: Create a new invitation fails if negative expected guests entered
	  When I go to the new invitation page
		And I select "Schell Family" from "invitation_guest_id"
		And I select "Birthday!" from "invitation_party_id"
		And I fill in "invitation_expected_attendees" with "-5"
		And I press "Create Invitation"
		Then I should see "Expected attendees must be greater than 0"

	Scenario: Create a new invitation fails if pi expected guests entered
	  When I go to the new invitation page
		And I select "Schell Family" from "invitation_guest_id"
		And I select "Birthday!" from "invitation_party_id"
		And I fill in "invitation_expected_attendees" with "3.14159"
		And I press "Create Invitation"
		Then I should see "Expected attendees must be an integer"
		
	Scenario: Create a new invitation only updates for someone already invited
		When I go to the new invitation page
		And I select "Phelps Family" from "invitation_guest_id"
		And I select "Birthday!" from "invitation_party_id"
		And I fill in "invitation_expected_attendees" with "5"
		And I press "Create Invitation"
		Then I should see "The invitation for this guest has been updated."
		And I should see "Expected attendees: 5"
	
	# UPDATE METHODS

