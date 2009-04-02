# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ScopedAdminExtension < Radiant::Extension
  version "0.3"
  description "Extends multi_site to scope layouts, snippets and users to sites"
  url "http://spanner.org/radiant/scoped_admin"
  
  # the work here is done by multisite
  # once the classes are scoped, they become invisible to the wrong person
  # the only complications come from allowing shared users to switch between sites
    
  def activate
    Layout.send :is_site_scoped, :shareable => false
    Snippet.send :is_site_scoped, :shareable => false
    User.send :is_site_scoped, :shareable => true
    ApplicationHelper.send :include, ScopedHelper
    
    admin.users.edit.add :form, "choose_site", :after => "edit_roles" 
    admin.layouts.edit.add :form, "choose_site", :before => "edit_timestamp" 
    admin.snippets.edit.add :form, "choose_site", :before => "edit_filter" 

    admin.users.index.add :top, "admin/shared/site_jumper"
    admin.layouts.index.add :top, "admin/shared/site_jumper"
    admin.snippets.index.add :top, "admin/shared/site_jumper"
  end
  
end
