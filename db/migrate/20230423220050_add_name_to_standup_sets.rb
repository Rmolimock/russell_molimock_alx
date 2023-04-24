class AddNameToStandupSets < ActiveRecord::Migration[7.0]
  def change
    add_column :standup_sets, :name, :string
  end
end
