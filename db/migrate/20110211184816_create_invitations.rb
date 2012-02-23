class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.integer :party_id
      t.integer :guest_id
	  t.integer :host_id
      t.string :invite_code
      t.integer :expected_attendees
      t.integer :actual_attendees
      t.timestamps
    end
  end

  def self.down
    drop_table :invitations
  end
end
