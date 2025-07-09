class GameEvent < ApplicationRecord
	validates :game_type, inclusion: { in: ['COMPLETED'], message: "is not allowed" }
	belongs_to :user
end
