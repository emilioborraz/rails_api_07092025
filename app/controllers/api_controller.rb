class ApiController < ApplicationController
  allow_unauthenticated_access only: %i[ health user ]

  def health
  	head :ok
  end

  def user
  	@new_user = User.create email_address: params[:email], password: params[:password], password_confirmation: params[:password]
  	if !@new_user.errors.empty?
	    render json: @new_user.errors, status: :unprocessable_entity
	  else
      head :created
    end
  end

  def details
  	render json: @session.user.details_stats, status: :ok
  end
end
