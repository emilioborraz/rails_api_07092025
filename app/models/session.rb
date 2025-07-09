class Session < ApplicationRecord
  has_secure_token :auth_token, length: 36
  belongs_to :user
end
