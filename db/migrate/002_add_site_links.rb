class AddSiteLinks < ActiveRecord::Migration
  def self.up
    default = Site.catchall
    [:layout, :snippet, :user].each do |klass|
      klass.to_s.classify.constantize.find_without_site(:all, :conditions => 'site_id IS NULL').each do |thing| 
        thing.site = default
        thing.save
      end
    end
  end
  
  def self.down
  end
end
