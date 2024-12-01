class AddDefaultToViewsInPosts < ActiveRecord::Migration[7.1]
  def change
    Post.where(views: nil).update_all(views: 0)
    change_column_default :posts, :views, 0
    change_column_null :posts, :views, false
  end
end
