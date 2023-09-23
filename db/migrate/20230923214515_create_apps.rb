class CreateApps < ActiveRecord::Migration[7.0]
  def change
    create_table :apps, id: :uuid do |t|
      t.string :name, uniqueness: true
      t.string :token, uniqueness: true

      t.timestamps
    end
  end
end
