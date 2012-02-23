class CreateGifts < ActiveRecord::Migration
  def self.up
    create_table :gifts do |t|
      t.integer :invitation_id
      t.date :note_sent_on
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :gifts
  end
end
