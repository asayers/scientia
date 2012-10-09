class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string      :name
      t.string      :slug
      t.references  :user
      t.references  :template
      t.references  :bibliography
      t.text        :body
      t.text        :html
      t.text        :latex
      t.binary      :pdf
      t.text        :warnings

      t.timestamps
    end
    
    add_index :documents, :slug
    add_index :documents, :user_id
    add_index :documents, :template_id
    add_index :documents, :bibliography_id
  end
end
