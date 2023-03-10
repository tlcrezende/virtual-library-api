class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.text :title, :null => false
      t.text :author, :null => false
      t.integer :genre, :default => 0

      t.timestamps
    end
  end
end
