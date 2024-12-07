class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      jwt = JWT.encode(
        {
          user_id: user.id,         # the data to encode
          email: user.email,        # include email if needed in the JWT
          is_admin: user.is_admin,  # include the is_admin field
          exp: 24.hours.from_now.to_i # the expiration time
        },
        Rails.application.credentials.fetch(:secret_key_base), # the secret key
        "HS256" # the encryption algorithm
      )
      render json: { jwt: jwt, user_id: user.id, email: user.email, is_admin: user.is_admin }
    else
      render json: {}, status: :unauthorized
    end
  end
end
