class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.integer :person_id
      t.integer :requester_id
      t.text :notes
      t.integer :fair
      t.integer :fast
      t.integer :pay
      t.integer :comm
      t.boolean :tos_viol
      t.boolean :scammer
      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end
