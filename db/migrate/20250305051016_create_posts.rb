class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :email
      t.string :title
      t.text :body

      t.timestamps
    end
    add_index :posts, :title, unique: true
  end
end
