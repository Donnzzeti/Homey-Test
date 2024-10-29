class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :project, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.references :admin, null: true, foreign_key: true

      t.timestamps
    end
  end
end
