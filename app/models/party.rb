require 'chronic'
class Party < ActiveRecord::Base
    attr_accessible :party_type_id, :host_id, :name, :location_id, :date, :start_time, :end_time, :description, :rsvp_date, :public

	belongs_to :host
	belongs_to :location
	belongs_to :party_type
	has_many :invitations, :dependent => :destroy
	has_many :guests, :through => :host
	
	
	
	# Callback
	before_validation :convert_dates
	
	#Validations
	validates_presence_of :party_type_id, :host_id, :name, :date, :start_time, :end_time, :rsvp_date, :location_id
	#Datetime validation not needed since we call convert dates
	#validates_datetime :date, :rsvp_date, :start_time, :end_time, :message => "can't be blank"
	validates_date :date, :on_or_after => lambda { Date.current }, :on_or_after_message => "must be after today's date"
	validates_date :rsvp_date, :on_or_before => :date, :on_or_before_message => "must be before party date"
	validates_time :end_time, :after => :start_time, :after_message => "must be after start time"
	
	scope :for_host, lambda {|host_id| where("host_id = ?", host_id) }
	scope :all, order(:date)
	scope :upcoming, where('date >= ?', Time.now.strftime("%Y-%m-%d"))
	scope :past, where('date < ?', Time.now.strftime("%Y-%m-%d"))
	
	def time
		"#{self.start_time.strftime("%I:%M%p")} - #{self.end_time.strftime("%I:%M%p")}"
	end
	
	def upcoming?
		return Time.now <= self.date
	end
	
	def convert_dates
    sd, rd = self.date, self.rsvp_date
	unless sd.nil? and rd.nil?
		self.date = Chronic.parse(sd).to_date
		self.rsvp_date = Chronic.parse(rd).to_date
	end
	end
#	def validate
#	 errors[:base] << "Date must be after today's date" if date.strftime("%m/%y/%d") < Time.now.strftime("%m/%y/%d")
#	 errors[:base] << "RSVP date must be on or after today's date" if rsvp_date.strftime("%m/%y/%d") < Time.now.strftime("%m/%y/%d")
#	 errors[:base] << "RSVP date must be before the actual party date" if rsvp_date.strftime("%m/%y/%d") >= date.strftime("%m/%y/%d")
#	 errors[:base] << "End time must be after start time" if end_time <= start_time
#	end
	
end
