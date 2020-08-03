class Api::V1::ProfileController < ApplicationController
  def index
    query_param = params[:q]
    default_limit = 10

    @profiles = if query_param
                  Profile.where('username ~* :q OR organization ~* :q OR location ~* :q
                                 OR fullname ~* :q',
                                { q: query_param })
                else
                  Profile.limit(default_limit)
                end

    render json: @profiles, status: :ok
  end

  def show
    @profile = Profile.find_by_username(params[:id])

    if @profile
      render json: @profile, status: :ok
    else
      render json: {}, status: :not_found
    end
  end
end
