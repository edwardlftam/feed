module Actions
  module Articles
  end
end

Dir[File.dirname(__FILE__) + '/articles/*.rb'].each { |f| require f }