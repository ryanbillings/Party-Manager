require 'chronic'
# FACTORIES FOR PM
# -------------------------------
# Create factory for Host class
   Factory.define :host do |h|
    h.first_name "Ryan"
    h.last_name "Billings"
    h.username { |a| "#{a.first_name}.#{a.last_name}".downcase }
    h.email { |a| "#{a.first_name}.#{a.last_name}@example.com".downcase }
    h.password "foobar"
    h.password_confirmation { |a| a.password }
  end
  
# Create factory for Guest class
  Factory.define :guest do |g|
	g.association :host
    g.name "Billings Fam"
	g.email "ryj.billings@gmail.com"
	g.notes "The Billings Family (Ryan, Ted, Mom, Dad)"
  end
  
   #Create factory for location
  Factory.define :location do |l|
    l.association :host
	l.name "My House"
	l.street "55 Rathbun Road"
	l.city "Natick"
	l.state "MA"
	l.zip "01760"
	l.latitude 0
	l.longitude 0
  end
  
  
  #Create factory for party type
  Factory.define :party_type do |pt|
	pt.name "Graduation"
	pt.active true
  end
  
 
  
  #Create factory for Party class
  Factory.define :party do |p|
	p.association :host
	p.association :party_type
	p.association :location
	p.name "Graduation Party"
	p.date "05/05/2011"
    p.rsvp_date "03/05/2011"
	p.start_time "12:00:00"
    p.end_time { |a| a.start_time + 3.hours }
	p.description "My Graduation Party!"
  end
  
  Factory.define :invitation do |i|
    i.host_id { |g| g.host_id }
	i.association :guest
	i.association :party
	i.expected_attendees 5
	#i.actual_attendees 5
	i.invite_code "123456asdf"
  end
  
  Factory.define :gift do |g|
	g.association :invitation
	g.description "Thank you so much for the $50 coupon to best buy"
	g.note_sent_on 1.week.from_now
  end
  
  
  
