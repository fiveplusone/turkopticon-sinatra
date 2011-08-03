class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :name
      t.string :email
      t.string :hashed_password
      t.string :salt
      t.boolean :email_verified
      t.boolean :is_admin
      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
