require 'open-uri'
require 'gh_scraper/parse_profile'
require 'gh_scraper/request_gh'

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
    @profile = Profile.find(params[:id])
    render json: @profile, status: :ok

  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  end

  def create
    profile_url = profile_params[:profile_url]
    username = profile_params[:username]

    gh_response = RequestGh.get(profile_url)

    if gh_response[:error]
      render json: gh_response[:content], status: gh_response[:status]
    else
      parser = ParseProfile.new(gh_response[:content])
      fields = parser.parse
      profile = Profile.new(username: username, profile_url: profile_url, **fields)

      if profile.save
        render json: {}, status: :created
      else
        render_error(profile.errors.full_message[0], :unprocessable_entity)
      end
    end
  end

  def update
    profile = Profile.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  else
    profile_url = profile_params[:profile_url]
    gh_response = RequestGh.get(profile_url)

    if gh_response[:error]
      render json: gh_response[:content], status: gh_response[:status]
    else
      parser = ParseProfile.new(gh_response[:content])
      fields = parser.parse

      if profile.update(fields)
        render json: profile, status: :ok
      else
        render_error(profile.errors.full_message[0], :unprocessable_entity)
      end
    end
  end

  rescue_from ActionController::ParameterMissing do |e|
    render json: { error: e.message }, status: :bad_request
  end

  private

  def profile_params
    params.require(:profile).permit(:username, :profile_url)
  end
end
