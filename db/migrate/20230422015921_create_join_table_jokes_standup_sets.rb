class CreateJoinTableJokesStandupSets < ActiveRecord::Migration[7.0]
  def change
    create_join_table :jokes, :standup_sets do |t|
      # t.index [:joke_id, :standup_set_id]
      # t.index [:standup_set_id, :joke_id]
    end
  end
end
