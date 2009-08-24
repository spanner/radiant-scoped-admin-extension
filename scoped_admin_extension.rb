# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ScopedAdminExtension < Radiant::Extension
  version "0.5"
  description "Calls multi_site to site-scope users, snippets and layouts."
  url "http://spanner.org/radiant/scoped_admin"
  
  # the work here is done by multi_site
  # once the classes are scoped, they become invisible to the wrong person
  # the only complications come from allowing sharing between sites
    
  def activate
    Layout.send :is_site_scoped
    Snippet.send :is_site_scoped
    User.send :is_site_scoped, :shareable => true
    ApplicationHelper.send :include, ScopedHelper
        
    unless admin.users.edit.form && admin.users.edit.form.include?('choose_site')
      admin.users.edit.add :form, "choose_site", :after => "edit_roles" 
      admin.layouts.edit.add :form, "choose_site", :before => "edit_timestamp" 
      admin.snippets.edit.add :form, "choose_site", :before => "edit_filter" 
      admin.users.index.add :top, "admin/shared/site_jumper"
      admin.layouts.index.add :top, "admin/shared/site_jumper"
      admin.snippets.index.add :top, "admin/shared/site_jumper"
    end
  end
end
