module RedmineLightbox
  module Patches
    module ControllerPatch
      extend ActiveSupport::Concern

      included do
        unloadable

        helper :redmine_lightbox
      end
    end
  end
end
