Feature: Manage account
	As a party host
	I want to be able to manage personal information
	So I can use the system effectively

	Background:
	  Given a logged in user
	
	Scenario: Edit my first name
		When I go to my account page
		And I fill in "host_first_name" with "Mark"
		And I press "Update"
		Then I should see "Welcome, Mark Heimann"

	Scenario: Edit my last name
		When I go to my account page
		And I fill in "host_last_name" with "Ho"
		And I press "Update"
		Then I should see "Welcome, An Ho"

	Scenario: Edit my email
		When I go to my account page
		And I fill in "host_email" with "a_heimann@example.com"
		And I press "Update"
		And I click on the link "My Account"
		Then the "host_email" field should contain "a_heimann@example"
	
	Scenario: Change my password
		When I go to my account page
		And I fill in "host_password" with "supersecret"
		And I fill in "host_password_confirmation" with "supersecret"
		And I press "Update"
		And I click on the link "Logout"
		And I go to the login page
    And I fill in the following:
      | Username | an.heimann  |
      | Password | supersecret |
    And I press "Log in"
		Then I should see "You are now logged in"
		And I should see "Welcome, An Heimann"
		