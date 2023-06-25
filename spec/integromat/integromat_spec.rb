require "integromat"

RSpec.describe Integromat do
  let(:data) { { username: "andrewdsilva" } }
  let(:result) do
    {
      "date"         => "Sun, 25 Jun 2023 12:01:36 GMT",
      "content-type" => "text/plain; charset=utf-8",
      "connection"   => "keep-alive",
      "x-powered-by" => "Make Gateway/production"
    }
  end

  describe "Integromat" do
    let(:webhook_class) { Integromat::Webhook }
    let(:default_url) { "https://hook.make.com" }
    let(:instance) { webhook_class.new(:user_register) }

    describe "Hook url" do
      it { expect(instance.send(:api_url)).to eq default_url }

      it "Hook path has val" do
        id = webhook_class.new(:nil, "55c9w8uuucdxfpy77uyrjspo1j956i2n").send(:web_hook_id)

        expect(id).to eq "55c9w8uuucdxfpy77uyrjspo1j956i2n"
      end
    end

    it "Base uri" do
      expect(Integromat.config.base_uri).to eq default_url
    end

    describe "Trigger" do
      it "Configuration missing" do
        expect do
          webhook_class.new(:wrong_hook_name).trigger
        end.to raise_error(Integromat::IntegromatMisConfiguration)
      end

      it "Trigger" do
        stub_request(:post, default_url).with(body: data).to_return(body: result.to_json)
        response = webhook_class.new(nil, "").trigger(data)

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)["date"]).not_to eq nil
      end
    end

    describe "With configuration" do
      it "With base uri" do
        Integromat.configure { |c| c.base_uri = "https://hook.eu2.make.com" }

        url = webhook_class.new(:nil, "55c9w8uuucdxfpy77uyrjspo1j956i2n").send(:api_url)

        expect(url).to eq "https://hook.eu2.make.com"
      end

      it "With base uri" do
        Integromat.configure { |c| c.web_hooks = { user_register: "55c9w8uuucdxfpy77uyrjspo1j956i2n" } }

        path = instance.send(:hook_path)

        expect(path).to eq "/55c9w8uuucdxfpy77uyrjspo1j956i2n"
      end
    end
  end
end
