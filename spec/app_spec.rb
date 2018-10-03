describe App do
  describe "GET /" do
    subject { get "/" }

    it { should be_ok }
  end

  describe "POST /webhook" do
    before do
      ENV["SLACK_WEBHOOK_URL"] = webhooK_url
      ENV["SLACK_CHANNEL"]     = env_channel
      ENV["SLACK_USERNAME"]    = username

      allow(App).to receive(:post_slack)
    end

    let(:webhooK_url) { "https://hooks.slack.com/services/XXXXXXXX/XXXXXXXX/XXXXXXXX" }
    let(:env_channel) { "#general" }
    let(:username)    { "Docker Hub Build" }
    let(:message) do
      <<~MSG
        Build finished by @trustedbuilder :beer:
        svendowideit/testhook:latest
        https://registry.hub.docker.com/u/svendowideit/testhook/
      MSG
    end

    let(:payload) do
      <<~JSON
        {
          "callback_url": "https://registry.hub.docker.com/u/svendowideit/testhook/hook/2141b5bi5i5b02bec211i4eeih0242eg11000a/",
          "push_data": {
            "images": [
              "27d47432a69bca5f2700e4dff7de0388ed65f9d3fb1ec645e2bc24c223dc1cc3",
              "51a9c7c1f8bb2fa19bcd09789a34e63f35abb80044bc10196e304f6634cc582c"
            ],
            "pushed_at": 1.417566161e+09,
            "pusher": "trustedbuilder",
            "tag": "latest"
          },
          "repository": {
            "comment_count": "0",
            "date_created": 1.417494799e+09,
            "description": "",
            "dockerfile": "",
            "full_description": "Docker Hub based automated build from a GitHub repo",
            "is_official": false,
            "is_private": true,
            "is_trusted": true,
            "name": "testhook",
            "namespace": "svendowideit",
            "owner": "svendowideit",
            "repo_name": "svendowideit/testhook",
            "repo_url": "https://registry.hub.docker.com/u/svendowideit/testhook/",
            "star_count": 0,
            "status": "Active"
          }
        }
      JSON
    end

    context "without channel in params" do
      subject { post "/webhook", payload, { "CONTENT_TYPE" => "application/json" } }

      it { should be_ok }

      it "called post_slack" do
        subject

        expect(App).to have_received(:post_slack).
                         with(webhook_url: webhooK_url, channel: env_channel, username: username, message: message)
      end
    end

    context "with empty channel in params" do
      subject { post "/webhook?channel=", payload, { "CONTENT_TYPE" => "application/json" } }

      it { should be_ok }

      it "called post_slack" do
        subject

        expect(App).to have_received(:post_slack).
                         with(webhook_url: webhooK_url, channel: env_channel, username: username, message: message)
      end
    end

    context "with channel in params" do
      subject { post "/webhook?channel=random", payload, { "CONTENT_TYPE" => "application/json" } }

      it { should be_ok }

      it "called post_slack" do
        subject

        expect(App).to have_received(:post_slack).
                         with(webhook_url: webhooK_url, channel: "#random", username: username, message: message)
      end
    end
  end
end
