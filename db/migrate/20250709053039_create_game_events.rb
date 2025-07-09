class CreateGameEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :game_events do |t|
      t.string :game_name
      t.string :game_type
      t.datetime :occurred_at

      t.timestamps
    end
  end
end
