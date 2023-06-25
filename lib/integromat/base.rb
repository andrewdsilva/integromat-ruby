module Integromat
  class Base
    def post_hook(data)
      api.post(hook_path, data)
    end

    def web_hook_id
      @web_hook_id ||= config.web_hooks[hook_ref]
    end

    def api
      @api ||= Faraday.new(url: api_url) do |faraday|
        faraday.request :json
        faraday.response :logger, ::Logger.new($stdout), bodies: true
        faraday.adapter Faraday.default_adapter
      end
    end

    def zap_headers
      {
        "Accept" => " application/json",
        "Content-Type" => "application/json"
      }
    end

    def api_url
      config.base_uri.to_s
    end

    def hook_path
      "/#{web_hook_id}"
    end

    def config
      Integromat.config
    end
  end
end
