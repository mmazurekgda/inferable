require "rails_helper"

RSpec.describe "Home" do
  describe "GET /updates" do
    let(:model) { "ActiveEntity" }
    before(:each) do
      get "/inferable/updates", params: { model: model }
    end

    it "returns an empty list as no updates yet" do
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq([])
    end

    context "when the model is written in a plural form" do
      let(:model) { "active_entities" }
      it { expect(response).to have_http_status(:success) }
    end

    context "when the model name does not exist" do
      let(:model) { "sdafdf" }
      it { expect(response).to have_http_status(:bad_request) }
    end

    context "when the model name exists, but is not inferable" do
      let(:model) { "PlainEntity" }
      it { expect(response).to have_http_status(:bad_request) }
    end

    context "when a new inferable is created" do
      let(:model) { ActiveEntity.create.class.name }
      it "returns the model id and its inferable features" do
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq([{ "id" => 1, "inferable_feature" => 0.0 }])
      end
    end
  end
end
