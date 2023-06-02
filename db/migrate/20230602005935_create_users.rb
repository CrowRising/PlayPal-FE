class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :token
      t.string :google_id

      t.timestamps
    end
  end
end
