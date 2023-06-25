# frozen_string_literal: true

require "integromat/version"
require "integromat/exceptions"
require "integromat/config"
require "integromat/base"
require "integromat/webhook"

module Integromat
  class Error < StandardError; end

  def self.configure
    self.config ||= Integromat::Config.new
    yield(config) if block_given?
  end
end
