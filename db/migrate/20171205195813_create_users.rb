class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :nickname
      t.string :name
      t.string :provider
      t.string :email
      t.string :token
      t.string :image

      t.timestamps
    end
  end
end
