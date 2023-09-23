class CreateLobbies < ActiveRecord::Migration[7.0]
  def change
    create_table :lobbies, id: :uuid do |t|
      t.string :name, uniqueness: true
      t.references :app, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
