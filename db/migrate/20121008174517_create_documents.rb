class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string      :name
      t.string      :slug
      t.references  :user
      t.references  :template
      t.text        :body
      t.text        :warnings
      t.boolean     :public

      t.timestamps
    end
    
    add_index :documents, :slug
    add_index :documents, :user_id
    add_index :documents, :template_id
  end
end
