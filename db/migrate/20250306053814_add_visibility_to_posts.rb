class AddVisibilityToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :visibility, :boolean, default: true
  end
end
