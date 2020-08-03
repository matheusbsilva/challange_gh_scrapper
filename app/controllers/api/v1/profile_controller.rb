class Api::V1::ProfileController < ApplicationController
  def index
    query_param = params[:q]
    default_limit = 10

    @profiles = if query_param 
                  Profile.where('username ~* :q OR organization ~* :q OR location ~* :q',
                                { q: query_param })
                else
                  Profile.limit(default_limit)
                end

    render json: @profiles, status: :ok
  end
end
