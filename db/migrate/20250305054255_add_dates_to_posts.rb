class AddDatesToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :date_created, :datetime
    add_column :posts, :date_edited, :datetime
  end
end
