class AddUserIdToMinibookEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :minibook_entries, :user_id, :integer
  end
end
