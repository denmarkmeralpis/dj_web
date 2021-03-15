module DjWeb
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :authenticate_request

    private

    def authenticate_request
      if ENV['DJ_WEB_USERNAME'].blank? || ENV['DJ_WEB_PASSWORD'].blank?
        render text: 'Unauthorized request', status: 401
      else
        authenticate_or_request_with_http_basic do |user, pass|
          user == ENV['DJ_WEB_USERNAME'] && pass == ENV['DJ_WEB_PASSWORD']
        end
      end
    end
  end
end
