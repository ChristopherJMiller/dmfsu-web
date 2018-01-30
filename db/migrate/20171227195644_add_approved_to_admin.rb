class AddApprovedToAdmin < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :approved, :boolean, default: false
  end
end
