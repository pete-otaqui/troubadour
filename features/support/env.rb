require 'webrat'
require 'spec/expectations'

Webrat.configure do |config|
  config.mode = :mechanize
end

class WebratWorld
  include Spec::Matchers
  include Webrat::Methods
  include Webrat::Matchers
end

World do
  WebratWorld.new
end
 