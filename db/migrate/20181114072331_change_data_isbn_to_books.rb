class ChangeDataIsbnToBooks < ActiveRecord::Migration[5.0]
  def change
    change_column :books, :isbn, :string
  end
end
