module ScopedAdmin
  
  module User
    def self.included(base)
      base.extend ClassMethods
      base.is_site_scoped
      class << base
        alias_method_chain :scope_condition, :admin
      end
    end
  
    module ClassMethods

      # user works slightly differently, in that admin users are available to all sites.

      def scope_condition_with_admin
        "users.site_id = #{current_site!.id} OR users.admin = 1"
      end

    end
  end
end

