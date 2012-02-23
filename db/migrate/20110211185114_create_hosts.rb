class CreateHosts < ActiveRecord::Migration
  def self.up
    create_table :hosts do |t|
      t.string :first_name
      t.string :last_name
	  t.string :username
      t.string :password_hash
      t.string :password_salt
      t.string :email
	  t.string :role
      t.timestamps
    end
	#Host.create(:first_name => "Admin", :last_name => "Administrator", :username => "admin", :password_hash => "$2a$10$F62Nx0dpLdijYKPD/WXn9OkNsOsPXzQmCHpVV39bHawJ2IzzVGCaa", :password_salt => "$2a$10$F62Nx0dpLdijYKPD/WXn9O", :email => "cmu.partymanager@gmail.com", :role => "Administrator")
  end

  def self.down
    drop_table :hosts
  end
end
