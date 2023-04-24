class CreateStandupSets < ActiveRecord::Migration[7.0]
  def change
    create_table :standup_sets do |t|
      t.integer :number

      t.timestamps
    end
  end
end
