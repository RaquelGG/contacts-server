class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name, limit: 45, null: false
      t.string :surname, limit: 45, null: false
      t.string :email, limit: 45, null: false, unique: true
      t.string :tel, limit: 45, null: false
    end
  end
end
