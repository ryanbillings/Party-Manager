class CreatePartyTypes < ActiveRecord::Migration
  def self.up
    create_table :party_types do |t|
      t.string :name
      t.boolean :active, :default => true
      t.timestamps
    end
	PartyType.create :name => "Graduation"
	PartyType.create :name => "Birthday"
	PartyType.create :name => "Baby Shower"
	PartyType.create :name => "Generic"
  end
  
  

  def self.down
    drop_table :party_types
  end
end
