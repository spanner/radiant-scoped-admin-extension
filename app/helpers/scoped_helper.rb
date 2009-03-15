module ScopedHelper
  def self.included(base)

    base.module_eval do
      def title
        current_site.name || Radiant::Config['admin.title'] || 'Radiant CMS'
      end

      def subtitle
        current_site.subtitle || Radiant::Config['admin.subtitle'] || 'publishing for small teams'
      end
      
      def site_jumper
        render :partial => 'admin/shared/site_jumper'
      end
    end

  end
end
