Feature: Manage guests
	As a party host
	I want to be able to manage guest invitations
	So I can reduce the overhead of hosting parties

	Background:
	  Given a logged in user
		Given an existing birthday party
	
	# READ METHODS
	Scenario: View my guests
		When I go to my guests page
		Then I should see "My Guests" within "h1"
		And I should see "Name"
		And I should see "Email"
		And I should see "Add A New Guest"
		And I should see "Heimann Family"
		And I should see "Phelps Family"
		And I should see "Quesenberry Family"
		
	Scenario: View only my guests
		Given another host with parties
		When I go to my guests page
		Then I should see "Heimann Family"
		And I should see "Phelps Family"
		And I should see "Quesenberry Family"
		And I should not see "Schoenstein Family"
		And I should not see "Kroger Family"
	
	Scenario: View guest details
		Given an existing artis family guest
		When I go to this guest details page
		# Then show me the page
		Then I should see "Artis Family"
		And I should see "Email: artis5@example.com"
		And I should see "This is the song that runs under the credits..."	


	# CREATE METHODS
	Scenario: Create a new guest - no expected attendees field
		When I go to the new guest page
		Then I should not see expected attendees option
	
	Scenario: Create a new guest - no actual/confirmed attendees field
		When I go to the new guest page
		Then I should not see actual attendees option

	Scenario: Create a new guest - no invitation code field to be set
		When I go to the new guest page
		Then I should not see invite code option

	Scenario: Create a new guest is successful
		When I go to the new guest page
		And I fill in "guest_name" with "Mansar Family"
		And I fill in "guest_email" with "smansar@example.com"
		And I fill in "guest_notes" with "Your mother was a hamster and your father smelt of elderberries!"
		And I press "Create Guest"
		Then I should see "Guest was successfully created"
	
	Scenario: Create a guest fails because of an missing name
		When I go to the new guest page
		And I fill in "guest_email" with "smansar@example.com"
		And I press "Create Guest"
		Then I should see "Name can't be blank"
	
	Scenario: Create a guest fails because of an invalid email
		When I go to the new guest page
		And I fill in "guest_name" with "Mansar Family"
		And I fill in "guest_email" with "smansar@example,com"
		And I press "Create Guest"
		Then I should see "Email is not a valid format"
	
	
	# UPDATE METHODS
	Scenario: Edit a guest is successful
		Given an existing artis family guest
		When I go to edit this guest page
		And I fill in "guest_name" with "Rick Artis"
		And I press "Update Guest"
		Then I should see "Rick Artis"
		
	Scenario: Edit a guest fails because of an invalid email
		Given an existing artis family guest
		When I go to edit this guest page
		And I fill in "guest_email" with "newartis@example,com"
		And I press "Update Guest"
		Then I should see "Email is not a valid format"
