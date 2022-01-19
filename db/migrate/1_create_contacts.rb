class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.string :email, unique: true, null: false
      t.string :tel, null: false
    end
  end
end
