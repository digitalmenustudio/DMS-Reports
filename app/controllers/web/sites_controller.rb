module Web
  class SitesController < ApplicationController
    before_action { authorize :sites }

    def home
    end
  end
end
