class CreateQuestionnaires < ActiveRecord::Migration
  def self.up
    create_table :questionnaires do |t|
      t.string :title
      t.integer :difficulty
      t.integer :popularity
      t.integer :cost
      t.integer :nb_questions
      t.integer :point

      t.timestamps
    end
  end

  def self.down
    drop_table :questionnaires
  end
end
