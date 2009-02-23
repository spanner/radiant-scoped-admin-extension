module ScopedAdmin
  module ScopedController
    def self.included(base)
      base.class_eval {
        alias_method_chain :current_user, :site
      }
    end

    # we don't want to process site and root parameters until we know this is an admin user
    # so we may have to go back and reset current_site after authentication
    # non-admin users will be confined to the site they log into, and unable to log into anything but their own
  
    def current_user_with_site
      user = current_user_without_site
      if user && user.admin?

        if params[:site] && site = Site.find(params[:site])          
          @site = self.current_site = site
          
        elsif params[:root] && page = Page.find(params[:root])
          @site = self.current_site = page.root.site
        end
        
        set_current_site if @site
      end
      user
    end
  
  end
end