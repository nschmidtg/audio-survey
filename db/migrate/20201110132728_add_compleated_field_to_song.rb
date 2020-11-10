class AddCompleatedFieldToSong < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :compleated, :boolean, :default => false
  end
end
