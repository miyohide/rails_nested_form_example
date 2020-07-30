class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :kind, null: false
      t.string :street, null: false
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
