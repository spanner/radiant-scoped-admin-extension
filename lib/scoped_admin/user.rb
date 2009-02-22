module ScopedAdmin
  
  module User

    def self.included(base)
      base.extend ClassMethods
      class << base
        alias_method_chain :authenticate, :foreign_admin
      end

    end
  
    module ClassMethods

      def authenticate_with_foreign_admin(login, password)
        # we have to dig a bit deeper to get around the site filter
        users = find_every_without_site(:conditions => [ "login = ? AND admin = 1", login], :limit => 1)
        user = users.first
        if !user.nil? && user.authenticated?(password)
          user
        else
          authenticate_without_foreign_admin(login, password)
        end
      end
    
    end
  end
end

