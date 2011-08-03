class CreateRequesters < ActiveRecord::Migration
  def self.up
    create_table :requesters do |t|
      t.string :amzn_id
      t.string :amzn_name
      t.decimal :avg_val, :precision => 3, :scale => 2
      t.integer :review_count
      t.timestamps
    end
  end

  def self.down
    drop_table :requesters
  end
end
