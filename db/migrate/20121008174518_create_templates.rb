class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string      :name
      t.string      :slug
      t.references  :user
      t.text        :body
      t.text        :warnings

      t.timestamps
    end

    add_index :templates, :slug
    add_index :templates, :user_id
  end
end
