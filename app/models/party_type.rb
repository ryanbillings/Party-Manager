class PartyType < ActiveRecord::Base
    attr_accessible :name, :active
	
	#Relationships
	has_many :parties
	
	validates_presence_of :name
	scope :all, order('name')
	scope :active, where('active = ?', true)
	scope :for_party, lambda {|party_id| where("party_id = ?", party_id) }
end
