module Actions
  module Feeds
  end
end

Dir[File.dirname(__FILE__) + '/feeds/*.rb'].each { |f| require f }