module ScopedAdmin
  module ScopedController
    def self.included(base)
      base.class_eval {
        alias_method_chain :authenticate, :reset_site
      }
    end

    # we don't want to process site and root parameters until we know this is an entitled user
    # so we may have to go back and reset current_site after authentication
    # we could really do with some hooks here
  
    def authenticate_with_reset_site
      outcome = authenticate_without_reset_site
      if outcome && !current_user.site
        if params[:site_id] && site = Site.find(params[:site_id])          
          @site = self.current_site = site
        elsif params[:root] && page = Page.find(params[:root])
          @site = self.current_site = page.root.site
        elsif site = site_from_cookie
          @site = self.current_site = site
        end
        if @site
          set_current_site 
          set_site_cookie
        end
      end
      outcome
    end
  
  end
end