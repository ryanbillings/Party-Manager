require 'chronic'
class Location < ActiveRecord::Base
    attr_accessible :host_id, :name, :street, :city, :state, :zip, :latitude, :longitude
	
	#Relationships
	belongs_to :host
	has_many :parties, :dependent => :destroy
	
	before_create :geocode_address
	before_validation :geocode_address, :on=> :update
	
	
	#accepts_nested_attributes_for :parties, :reject_if => lambda { |party| party[:name].blank? }
	
	validates_presence_of :host_id, :name
	
	def geocode_address
			address_geo=self.address
			geo=Geokit::Geocoders::MultiGeocoder.geocode(address_geo)
			errors.add(:address, "Could not Geocode address") if !geo.success
			self.latitude, self.longitude = geo.lat,geo.lng if geo.success
	end
	
	def geocoded?
		latitude? && longitude?
	end
	
	def address
		"#{street},#{city},#{state}"
	end
	

	
	scope :for_host, lambda {|host_id| where('host_id = ?', host_id)}
end
