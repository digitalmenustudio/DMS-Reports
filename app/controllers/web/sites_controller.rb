module Web
  class SitesController < ApplicationController
    before_action { authorize :sites }
    before_action :authenticate_user!

    def home
    end
  end
end
