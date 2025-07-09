class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :game_events, dependent: :destroy
  validates :email_address, presence: true, uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email" }

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def subscription_status
    begin
      resource = "users/#{id}/billing"
      interviewsAccountsApi = InterviewsAccounts.new(api_key: ENV["THIRD_PARTY_API_KEY"])
      data = interviewsAccountsApi.fetch_data(resource)
    rescue ExternalApiError => e
      return ""
    end
    data.dig("subscription_status")
  end

  def details_stats
    {
      "user": {
        "id": id,
        "email": email_address,
        "stats": {
          "total_games_played": game_events.count(),
        },
        "subscription_status": subscription_status
      }
    }
  end
end
