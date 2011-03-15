class RemoveNbMcqInCategorie < ActiveRecord::Migration
  def self.up
    remove_column :categories, :nb_mcq
  end

  def self.down
    add_column :categories, :nb_mcq, :integer
  end
end
