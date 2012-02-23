class CreateGuests < ActiveRecord::Migration
  def self.up
    create_table :guests do |t|
      t.integer :host_id
      t.string :name
      t.string :email
      t.text :notes
      t.timestamps
    end
  end

  def self.down
    drop_table :guests
  end
end
