class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :token
      t.boolean :token_valid
      t.string :email
      t.string :location

      t.timestamps
    end
  end
end
