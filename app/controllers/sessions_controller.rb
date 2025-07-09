class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def create
    if user = User.authenticate_by(email_address: params[:email], password: params[:password])
      session = start_new_session_for user
      render json: {"token": session.auth_token}, status: :ok
    else
      render json: {"errors": "forbidden"}, status: :forbidden
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
end
