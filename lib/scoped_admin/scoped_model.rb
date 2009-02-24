module ScopedAdmin
  
  module ScopedModel
    def self.included(base)
      base.extend ClassMethods
      base.is_site_scoped #:shareable => true
      # class << base
      #   alias_method_chain :site_scope_condition, :shared
      # end
    end
  
    module ClassMethods

      # admin users are part of every site.

      # def site_scope_condition_with_shared
      #   condition = "#{table_name}.site_id = #{current_site!.id}"
      #   condition += " OR #{table_name}.admin = 1" if column_names.include?('admin')
      #   condition
      # end

    end
  end
end

