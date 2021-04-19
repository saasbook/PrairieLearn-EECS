# model for user
class User < ApplicationRecord
  # Add more Authentication Providers here.
  enum provider: {github: 1}, _prefix: :provider

  # Each (uid, provider) pair should be unique.
  validates :uid, uniqueness: { scope: :provider }

  """
  def auth_provider
    {
      'github' => 'Github'
    }[provider]
  end
  """

  def self.find_github_user(uid)
    User.find_by(
      provider: User.providers[:github],
      uid: uid
    )
  end
end
