require 'json'

module JQuery
  def self.ready(&block)
    yield if block_given?
  end
end
