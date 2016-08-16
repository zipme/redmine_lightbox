module RedmineLightbox
  module Hooks
    class ViewHooks < Redmine::Hook::ViewListener

      render_on :view_layouts_base_html_head, partial: 'redmine_lightbox/view_layouts_base_html_head'
      render_on :view_layouts_base_body_bottom, partial: 'redmine_lightbox/view_layouts_base_body_bottom'


    end
  end
end
