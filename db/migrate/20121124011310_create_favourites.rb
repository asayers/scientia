class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.string :name
      t.string :slug
      t.string :type
      t.references :user

      t.timestamps
    end
    add_index :favourites, :user_id
    add_index :favourites, :slug
  end
end
