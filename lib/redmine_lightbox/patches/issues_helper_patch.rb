require_dependency 'issues_helper'

module RedmineLightbox
  module Patches
    module IssuesHelperPatch
      extend ActiveSupport::Concern

      included do
        alias_method_chain :show_detail, :only_path_disabled
      end

      def show_detail_with_only_path_disabled(detail, no_html = false, options={})
        show_detail_without_only_path_disabled(detail, no_html, options.merge(:only_path => false))
      end

    end
  end
end

unless IssuesHelper.included_modules.include?(RedmineLightbox::Patches::IssuesHelperPatch)
  IssuesHelper.send(:include, RedmineLightbox::Patches::IssuesHelperPatch)
end
