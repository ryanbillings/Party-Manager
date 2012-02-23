class Guest < ActiveRecord::Base
    attr_accessible :host_id, :name, :email, :notes
	
	belongs_to :host
	has_many :invitations, :dependent => :destroy
	has_many :gifts, :through => :invitations
	
	#accepts_nested_attributes_for :invitations, :reject_if => lambda { |invitation| invitation[:expected_attendees].blank? }
	
	validates_presence_of :name, :email, :host_id
	validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a valid format"
	
	scope :for_host, lambda {|host_id| where("host_id = ?", host_id) }
	scope :all, :order => "name"
	scope :all_email, :order => "email"
end
