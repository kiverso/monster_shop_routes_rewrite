class ChangeImageDefaultInItems < ActiveRecord::Migration[5.1]
  def change
    change_column_default :items, :image, nil
  end
end
