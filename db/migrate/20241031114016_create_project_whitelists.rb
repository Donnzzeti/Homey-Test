class CreateProjectWhitelists < ActiveRecord::Migration[7.1]
  def change
    create_table :project_whitelists do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
