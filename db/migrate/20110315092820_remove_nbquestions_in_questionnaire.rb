class RemoveNbquestionsInQuestionnaire < ActiveRecord::Migration
  def self.up
    remove_column :questionnaires, :nb_questions
  end

  def self.down
    add_column :questionnaires, :nb_questions, :integer
  end
end
