# frozen_string_literal: true

require "integromat/version"
require "integromat/config"

module Integromat
  class Error < StandardError; end

  def self.configure
    self.config ||= Integromat::Config.new
    yield(config) if block_given?
  end
end
