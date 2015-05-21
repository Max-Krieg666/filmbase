class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.belongs_to :album, index: true, foreign_key: true
      t.string :title
      t.attachment :object, null: false
      t.integer :position

      t.timestamps null: false
    end
  end
end
