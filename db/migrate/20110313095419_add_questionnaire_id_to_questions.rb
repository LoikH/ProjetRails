class AddQuestionnaireIdToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :questionnaire_id, :integer
  end

  def self.down
    remove_column :questions, :questionnaire_id
  end
end
