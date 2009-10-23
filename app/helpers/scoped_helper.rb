module ScopedHelper
  def self.included(base)

    base.module_eval do
      def title
        t = current_site.name 
        t = Radiant::Config['admin.title'] || 'Radiant CMS' if t.blank?
        t
      end

      def subtitle
        st = current_site.subtitle
        st = Radiant::Config['admin.subtitle'] || 'publishing for small teams' if st.blank?
        st
      end

    end
  end
end
