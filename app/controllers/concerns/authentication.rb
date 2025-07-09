module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private
    def authenticated?
      auth_header = request.headers['Authorization']

      return false if auth_header.blank? || !auth_header.start_with?('Bearer ')

      token = auth_header.split(' ', 2).last

      return false if token.blank?
      @session = Session.find_by auth_token: token

      return false if @session.blank?

      true
    end

    def require_authentication
      return true if authenticated?
      render json: {"errors": "forbidden"}, status: :forbidden
    end

    def request_authentication
      session[:return_to_after_authenticating] = request.url
      redirect_to new_session_path
    end

    def start_new_session_for(user)
      user.sessions.create!(user_agent: '', ip_address: '').tap do |session|
        session
      end
    end

    def terminate_session
      Current.session.destroy
      cookies.delete(:session_id)
    end
end
