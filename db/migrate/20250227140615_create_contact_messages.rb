class CreateContactMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :contact_messages do |t|
      t.string :name
      t.string :email, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
