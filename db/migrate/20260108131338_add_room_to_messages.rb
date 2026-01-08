class AddRoomToMessages < ActiveRecord::Migration[8.0]
  def up
    Message.delete_all
    add_reference :messages, :room, null: false, foreign_key: true
  end

  def down
    remove_reference :messages, :room
  end
end
