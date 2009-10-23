class AddSiteLinks < ActiveRecord::Migration
  def self.up
    Page.current_site = Site.catchall
    [:layout, :snippet, :user].each do |klass|
      klass.to_s.classify.constantize.reset_column_information
      klass.to_s.classify.constantize.find_without_site(:all, :conditions => 'site_id IS NULL').each do |thing| 
        thing.update_attribute(:site_id, Page.current_site.id)
      end
    end
  end
  
  def self.down
  end
end
