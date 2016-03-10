class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :isbn
      t.string :yearofpub
      t.string :image
      t.string :buylink
      t.string :description
      t.string :category

      t.timestamps null: false
    end
  end
end
