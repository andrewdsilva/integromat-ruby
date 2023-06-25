module Integromat
  class Webhook < Base
    attr_accessor :hook_ref

    def initialize(hook_ref, hook_id = nil)
      super()

      self.hook_ref = hook_ref

      @web_hook_id = hook_id if hook_id
    end

    def trigger(data = {})
      unless web_hook_id
        raise IntegromatMisConfiguration, "No hook configured for #{hook_ref}. Configured hooks: #{config.web_hooks}"
      end

      post_hook(data)
    end
  end
end
