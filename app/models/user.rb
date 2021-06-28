# model for user
class User < ApplicationRecord
  # Add more Authentication Providers here
  # It is unlikely that this app need other providers
  enum provider: {github: 1}, _prefix: :provider

  # Each (uid, provider) pair should be unique
  validates :uid, uniqueness: { scope: :provider }

  def self.find_github_user(uid)
    User.find_by(
      provider: User.providers[:github],
      uid: uid
    )
  end
end
