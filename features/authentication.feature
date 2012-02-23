Feature: Authentication
	As a host
	I want to create and access an account on the system
	In order to manage my parties
	
	Scenario: Signup
		Given I am on the signup page
		When I fill in the following:
      | First name       | Mark                 |
      | Last name        | Heimann              |
      | Username         | mheimann             |
      | Email            | mheimann@example.com |
      | Password         | 123456               |
      | Confirm Password | 123456               |
    And I press "Sign up"
    Then I should see "You are now logged in"

	Scenario: Signup failure because required fields missing
		Given I am on the signup page
		When I fill in the following:
      | First name       |                |
      | Last name        |                |
      | Username         |                |
      | Email            | mh@example.com |
      | Password         |                |
      | Confirm Password |                |
    And I press "Sign up"
    Then I should see "First name can't be blank"
	  And I should see "Last name can't be blank"
	  And I should see "Username can't be blank"
	  And I should see "Password can't be blank"

	Scenario: Signup failure because of invalid entries
		Given I am on the signup page
		When I fill in the following:
      | First name       | Mark                 |
      | Last name        | Heimann              |
      | Username         | mheimann             |
      | Email            | mheimann@example,com |
      | Password         | 123456               |
      | Confirm Password | 654321               |
    And I press "Sign up"
    Then I should see "Email is invalid"
	  And I should see "Password doesn't match confirmation"

  Scenario: Login successful
    Given a valid user
    When I go to the login page
    And I fill in the following:
      | Username | an.heimann |
      | Password | fredbar    |
    And I press "Log in"
    Then I should see "You are now logged in"
		And I should see "Welcome, An Heimann"
		
  Scenario: Login failed
    Given a valid user
    When I go to the login page
    And I fill in the following:
      | Username | an.heimann |
      | Password | foobar     |
    And I press "Log in"
    Then I should see "Invalid login or password"
		
  Scenario: Logout
    Given a logged in user
    When I go to the home page
    And I click on the link "Logout"
    Then I should see "You have been logged out"
