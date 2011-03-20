class CreateScorings < ActiveRecord::Migration
  def self.up
    create_table :scorings do |t|
      t.integer :user_id
      t.integer :category_id
      t.integer :score

      t.timestamps
    end
  end

  def self.down
    drop_table :scorings
  end
end
