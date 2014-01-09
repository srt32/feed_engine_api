require 'spec_helper'

describe "Commits API" do
  describe "GET /projects/:project_id/commits" do
    it "returns all the project's commits" do
      commit = FactoryGirl.create :commit, commit_hash: "098abc"
      commit2 = FactoryGirl.create :commit, commit_hash: "765qwe"
      commit3 = FactoryGirl.create :commit, commit_hash: "foobar"
      commit3.project_id = 2
      commit3.save

      get "/projects/#{commit.project_id}/commits"

      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      commit_hashes = body.map { |c| c["commit_hash"] }

      expect(commit_hashes).to match_array(["098abc",
                                            "765qwe"])
    end
  end
end