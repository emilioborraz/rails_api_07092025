class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :game_events, dependent: :destroy
  validates :email_address, presence: true, uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email" }

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def details_stats
    {
      "user": {
        "id": id,
        "email": email_address,
        "stats": {
          "total_games_played": game_events.count(),
        }
      }
    }
  end
end
