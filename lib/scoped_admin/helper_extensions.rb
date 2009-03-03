module ScopedAdmin::HelperExtensions
  def self.included(base)

    base.module_eval do

      # overriding a method in MultiSite::HelperExtensions
      # to prevent sited userse from seeing the site jumper

      def subtitle
        if current_user.site
          current_site.subtitle
        else
          site_jumper
        end
      end
      
    end
  end
end
