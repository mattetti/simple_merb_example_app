require "rubygems"

# Add the local gems dir if found within the app root; any dependencies loaded
# hereafter will try to load from the local gems before loading system gems.
if (local_gem_dir = File.join(File.dirname(__FILE__), '..', 'gems')) && $BUNDLE.nil?
  $BUNDLE = true; Gem.clear_paths; Gem.path.unshift(local_gem_dir)
end

require "merb-core"
require "spec" # Satisfies Autotest and anyone else not using the Rake tasks

# this loads all plugins required in your init file so don't add them
# here again, Merb will do it for you
Merb.start_environment(:testing => true, :adapter => 'runner', :environment => ENV['MERB_ENV'] || 'test')

Spec::Runner.configure do |config|
  config.include(Merb::Test::ViewHelper)
  config.include(Merb::Test::RouteHelper)
  config.include(Merb::Test::ControllerHelper)
end
    
Merb::Test.add_helpers do

  def create_default_user
    unless User.first(:login => "krusty")
      User.create(:login => "krusty", :password => "klown", :password_confirmation => "klown") or raise "can't create user'"
    end
  end
  
  def login
    create_default_user
    request("/login", {
      :method => "PUT",
      :params => {
        :login => "krusty",
        :password => "klown"
      }
    })
  end
  
end

