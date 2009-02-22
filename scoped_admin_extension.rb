# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ScopedAdminExtension < Radiant::Extension
  version "0.1"
  description "Extends multi_site to scope layouts, snippets and users to sites"
  url "http://spanner.org/radiant/scoped_admin"
  
  # define_routes do |map|
  #   map.namespace :admin, :member => { :remove => :get } do |admin|
  #     admin.resources :scoped_admin
  #   end
  # end
  
  def activate
    Layout.send :is_site_scoped
    Snippet.send :is_site_scoped
    User.send :is_site_scoped
    User.send :include, ScopedAdmin::User

    admin.layouts.index.add :top, "site_subnav"
    admin.users.index.add :top, "site_subnav"
    admin.snippets.index.add :top, "site_subnav"
  end
  
  def deactivate

  end
  
end
