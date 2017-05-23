class RenameMessagesToChats < ActiveRecord::Migration[5.1]
  def change
    rename_table :messages, :chats
  end
end
