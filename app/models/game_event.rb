class GameEvent < ApplicationRecord
	validates :game_type, inclusion: { in: ['COMPLETED'], message: "is not allowed" }
end
