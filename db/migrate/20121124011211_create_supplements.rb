class CreateSupplements < ActiveRecord::Migration
  def change
    create_table :supplements do |t|
      t.string :name
      t.string :type
      t.references :document

      t.timestamps
    end
    add_index :supplements, :document_id
  end
end
