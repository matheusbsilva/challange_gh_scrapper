class Api::V1::ProfileController < ApplicationController
  def index
    default_limit = 10

    @profiles = Profile.limit(default_limit)
    render json: @profiles, status: :ok
  end
end
