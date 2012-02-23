

class Invitation < ActiveRecord::Base
    attr_accessible :party_id, :guest_id, :invite_code, :expected_attendees, :actual_attendees, :host_id
	
	#Relationships
	belongs_to :party
	belongs_to :guest
	has_many :gifts, :dependent => :destroy
	has_one :host, :through => :guest
	
	validates_presence_of :expected_attendees, :host_id, :party_id, :guest_id
	validates_numericality_of :expected_attendees, :only_integer => true, :greater_than => 0
	validates_numericality_of :actual_attendees, :only_integer => true, :greater_than => 0, :allow_blank => true
	
	def self.authenticate(code)
    host = find_by_invite_code(code)
    return host if host
	end
	
	#private
	def total_expected
	self.expected_attendees.sum
	end
	
	def total_actual
	self.actual_attendees.sum
	end

	def generate_invite_code
	self.invite_code = rand(36**16).to_s(36)
	end

	def self.new_invite_code
	rand(36**16).to_s(36)
	end
	
	scope :for_guest, lambda {|guest_id| where("guest_id = ?", guest_id) }
	scope :get_id, lambda {|code| where("invite_code = ?", code) }
	scope :for_host, lambda {|host_id| where("host_id = ?", host_id) }
	scope :for_party, lambda {|party_id| where("party_id = ?", party_id) }
end
