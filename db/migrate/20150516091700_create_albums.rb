class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.belongs_to :film, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :person, index: true, foreign_key: true
      t.string :title

      t.timestamps null: false
    end
  end
end
