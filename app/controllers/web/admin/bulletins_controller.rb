# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      def index
        @bulletins = Bulletin.all
      end
    end
  end
end
