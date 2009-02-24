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
    Layout.send :include, ScopedAdmin::ScopedModel
    Snippet.send :include, ScopedAdmin::ScopedModel
    User.send :include, ScopedAdmin::ScopedModel
    Admin::ResourceController.send :include, ScopedAdmin::ScopedController
    
    [:layouts, :users, :snippets].each do |resource|
      admin.send(resource).index.add :top, "site_subnav"
    end

    admin.users.edit.add :form, "choose_site", :after => "edit_roles" 
    admin.layouts.edit.add :form, "choose_site", :before => "edit_timestamp" 
    admin.snippets.edit.add :form, "choose_site", :before => "edit_filter" 


  end
  
  def deactivate

  end
  
end
