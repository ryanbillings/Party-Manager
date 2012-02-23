class UserMailer < ActionMailer::Base
 
  def registration_confirmation(user, code, party, host)
	@user=user
	@code=code
	@party=party
	@host=host
    mail(:to => user.email, :subject => "You have been invited to a party!", :from => "cmu.partymanager@gmail.com")  
  end  
  
  def thank_you(guest, gift)
  @guest=guest
  @gift=gift
  mail(:to => guest.email, :subject => "Thank You!", :from => "cmu.partymanager@gmail.com")
  end
  
  def password_reset(email, password)
	#@host=Host.where(:email => email)
	@email=email
	@password=password
	mail(:to => @email, :subject => "Password Reset", :from => "cmu.partymanager@gmail.com")
  end
  
  def party_canceled(guest, host, party)
  @email = guest.email
  @name = guest.name
  @host = host
  @party = party
  mail(:to => @email, :subject => "Party Terminated", :from => "cmu.partymanager@gmail.com")
  end
end  
