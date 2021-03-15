# forzen_string_literal: true

require_dependency 'dj_web/application_controller'

module DjWeb
  class PagesController < ApplicationController
    def index
      @jobs = DelayedJob
    end
  end
end
