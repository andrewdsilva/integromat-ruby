module Integromat
  class Config
    attr_accessor :base_uri, :web_hooks

    def initialize
      self.base_uri = "https://hook.make.com"
      self.web_hooks = {}
    end
  end
end
