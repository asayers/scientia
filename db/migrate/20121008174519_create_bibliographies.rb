class CreateBibliographies < ActiveRecord::Migration
  def change
    create_table :bibliographies do |t|
      t.string :name
      t.string :slug
      t.references :user
      t.text :body

      t.timestamps
    end
    add_index :bibliographies, :user_id
    add_index :bibliographies, :slug
  end
end
