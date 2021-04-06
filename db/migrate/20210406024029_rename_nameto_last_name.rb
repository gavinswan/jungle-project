class RenameNametoLastName < ActiveRecord::Migration
  def change
    rename_column :users, :name, :last_name
  end
end
