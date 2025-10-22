require "rails_helper"

RSpec.describe "Dashboard", type: :request do 
    it "renders succesfully" do 
        get "/dashboard"
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Track").or include("Dashboard")
    end
end