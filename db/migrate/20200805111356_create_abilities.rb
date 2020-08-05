class CreateAbilities < ActiveRecord::Migration[6.0]
  def change
    create_table :abilities do |t|
      t.references :person, null: false, foreign_key: true
      t.string :ability_name, null: false

      t.timestamps
    end
  end
end
