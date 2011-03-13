class AddQuestionIdToReponse < ActiveRecord::Migration
  def self.up
    add_column :reponses, :question_id, :integer
  end

  def self.down
    remove_column :reponses, :question_id
  end
end
