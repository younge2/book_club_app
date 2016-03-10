class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :blurb
      t.integer :owner
      t.boolean :private

      t.timestamps null: false
    end
  end
end
