# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      def index
        @bulletins = Bulletin.all
        authorize([:admin, @bulletins])
      end
    end
  end
end
