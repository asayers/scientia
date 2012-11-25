class CreateSupplements < ActiveRecord::Migration
  def change
    create_table :supplements do |t|
      t.string :name
      t.string :slug
      t.string :type
      t.references :document

      t.timestamps
    end
    add_index :supplements, :document_id
    add_index :supplements, :slug
  end
end
