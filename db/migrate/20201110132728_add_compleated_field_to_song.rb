class AddCompleatedFieldToSong < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :completed, :boolean, :default => false
  end
end
