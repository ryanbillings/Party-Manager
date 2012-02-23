Feature: RSVP Management
  In order to make sure people can respond to invitations
  As a guest
  I want to be able to use my access code to view party details and rsvp

	Background:
	  Given a logged in user
		Given an existing birthday party
	
	# READ METHODS
	Scenario: View party details and rsvp as an invited guest
		Given a guest is invited to the birthday party
		When I go to the rsvp page
		And I fill in my invite code
		And I press "Enter"
		Then I should see "Birthday!"
		And I should see "My house"	
		And I should see "12:00 PM - 03:00 PM"
		And I should see "June 04, 2011"
		And I should see "A great and thrilling time will be had by all."
		When I fill in "invitation_actual_attendees" with "4"
		And I press "RSVP"
		Then I should see "Your RSVP is complete. Thank you."
		And I should see "Actual attendees: 4"
		






  
