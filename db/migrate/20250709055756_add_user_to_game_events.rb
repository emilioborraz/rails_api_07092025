class AddUserToGameEvents < ActiveRecord::Migration[8.0]
  def change
    add_reference :game_events, :user, null: false, foreign_key: true
  end
end
