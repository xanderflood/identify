class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :trackable, timeout_in: Rails.application.config.x.identify_sessions_timeout_seconds.seconds

  alias_attribute :uuid, :id

  # TODO consider supporting github OAuth as an omniauth provider
  # using the :omniauthable module and something based on this:
  #    https://github.com/omniauth/omniauth-github
end
