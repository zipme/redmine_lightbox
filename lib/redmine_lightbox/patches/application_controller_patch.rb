require_dependency 'application_controller'

module RedmineLightbox
  module Patches
    module ApplicationControllerPatch
      extend ActiveSupport::Concern

      included do
        unloadable

        helper :redmine_lightbox
      end
    end
  end
end

unless ApplicationController.included_modules.include?(RedmineLightbox::Patches::ApplicationControllerPatch)
  ApplicationController.send(:include, RedmineLightbox::Patches::ApplicationControllerPatch)
end
