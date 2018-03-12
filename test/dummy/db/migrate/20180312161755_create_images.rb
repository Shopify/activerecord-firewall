class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :alt
      t.string :url
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
