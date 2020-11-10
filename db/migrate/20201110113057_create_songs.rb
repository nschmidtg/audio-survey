class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :url
      t.integer :user_id
      t.integer :rating
      t.boolean :recognized
      t.string :recognize_text
      t.string :memory_description
      t.string :additional_description

      t.timestamps
    end
  end
end
