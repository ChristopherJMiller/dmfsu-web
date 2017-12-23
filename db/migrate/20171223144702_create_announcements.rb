class CreateAnnouncements < ActiveRecord::Migration[5.0]
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :post
      t.references :admin, index: true, foreign_key: true

      t.timestamps
    end
  end
end
