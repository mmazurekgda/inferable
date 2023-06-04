require 'rails_helper'

RSpec.describe "PendingRecords", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/inferable/index"
      expect(response).to have_http_status(:success)
    end
  end
end
