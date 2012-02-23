class Gift < ActiveRecord::Base
    attr_accessible :invitation_id, :note_sent_on, :description
	
	#Relationships
	belongs_to :invitation
	
	validates_presence_of :description, :invitation_id
	#has_one :guest, :through => :invitation
	
	#def guest_id
	#:guest_id
	#end
	scope :for_invitation, lambda {|invitation_id| where("invitation_id = ?", invitation_id) }
	scope :doesnt_exist, lambda {|invitation_id| where("invitation_id != ?", invitation_id)}

end
