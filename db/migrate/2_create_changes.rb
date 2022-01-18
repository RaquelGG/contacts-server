class CreateChanges < ActiveRecord::Migration[7.0]
  def change
    create_table :changes do |t|
      t.references :contact, foreign_key: true, null: false
      t.timestamp :date, default: -> { "CURRENT_TIMESTAMP" }, null: false
      t.string :name
      t.string :surname
      t.string :email
      t.string :tel
    end
  end
end
