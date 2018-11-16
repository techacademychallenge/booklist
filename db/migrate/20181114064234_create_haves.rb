class CreateHaves < ActiveRecord::Migration[5.0]
  def change
    create_table :haves do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps

      t.index [:user_id, :book_id], unique: true
    end
  end
end
