class CreateBooksClubs < ActiveRecord::Migration
  def change
    create_table :books_clubs do |t|
      t.references :book, index: true, foreign_key: true
      t.references :club, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
