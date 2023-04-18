class CreateJokes < ActiveRecord::Migration[7.0]
  def change
    create_table :jokes do |t|
      t.string :content
      t.string :source

      t.timestamps
    end
  end
end
