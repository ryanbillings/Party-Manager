ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "gmail.com",  
  :user_name            => "cmu.partymanager@gmail.com",  
  :password             => "carnegiemellon",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}  