class AddCategoryIdToQuestionnaire < ActiveRecord::Migration
  def self.up
    add_column :questionnaires, :category_id, :integer
  end

  def self.down
    remove_column :questionnaires, :category_id
  end
end
