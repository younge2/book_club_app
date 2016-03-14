class CreateBookstates < ActiveRecord::Migration
  def change
    create_table :bookstates do |t|
      t.integer :category
      t.references :book, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
