class CreateUserQuestionnaireJoin < ActiveRecord::Migration
  def self.up
    create_table 'questionnaires_users', :id=>false do |t|
      t.column 'questionnaire_id', :integer
      t.column 'user_id', :integer
    end
  end

  def self.down
    drop_table 'questionnaires_users'
  end
end
