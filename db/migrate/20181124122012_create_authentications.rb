class CreateAuthentications < ActiveRecord::Migration[5.1]
  def change
    create_table :authentications do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.string :provider, null: false
      t.string :uid, null: false
      t.timestamps null: false
    end

    add_index :authentications, [:provider, :uid], unique: true
  end
end
