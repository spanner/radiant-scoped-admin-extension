class AddSiteLinks < ActiveRecord::Migration
  def self.up
    default = Site.catchall
    [Layout, Snippet, User].each do |klass|
      klass.find_by_site_id(nil).each do |thing| 
        thing.site = default
        thing.save
      end
    end
  end
  
  def self.down
  end
end
