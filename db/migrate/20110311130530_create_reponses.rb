class CreateReponses < ActiveRecord::Migration
  def self.up
    create_table :reponses do |t|
      t.string :title
      t.boolean :correct

      t.timestamps
    end
  end

  def self.down
    drop_table :reponses
  end
end
