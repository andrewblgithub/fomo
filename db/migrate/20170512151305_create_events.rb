class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :created_by
      t.datetime :expires_at
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
