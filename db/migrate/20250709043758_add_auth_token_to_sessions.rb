class AddAuthTokenToSessions < ActiveRecord::Migration[8.0]
  def change
    add_column :sessions, :auth_token, :string
  end
end
