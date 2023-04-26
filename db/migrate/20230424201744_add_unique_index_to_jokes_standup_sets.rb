class AddUniqueIndexToJokesStandupSets < ActiveRecord::Migration[7.0]
  def up
    # Remove duplicates
    execute("DELETE FROM jokes_standup_sets")

    # Add unique constraint
    add_index :jokes_standup_sets, [:standup_set_id, :joke_id], unique: true
  end

  def down
    remove_index :jokes_standup_sets, [:standup_set_id, :joke_id]
  end
end
