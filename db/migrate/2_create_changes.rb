class CreateChanges < ActiveRecord::Migration[7.0]
  def change
    create_table :changes do |t|
      t.references :contact, foreign_key: true, null: false
      t.timestamp :date, default: -> { "CURRENT_TIMESTAMP" }, null: false
      t.string :name, limit: 45
      t.string :surname, limit: 45
      t.string :email, limit: 45
      t.string :tel, limit: 45
    end
  end
end
