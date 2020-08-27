class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.string :full_name
      t.datetime :birthday
      t.references :album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
