module Api
  module V1
    class CommitsController < ApplicationController

      def index
        project = Project.find(params[:project_id])
        commits = project.repos.map(&:commits).flatten # needs optimization
        render json: commits
      end

      def show
        commit = Commit.find(params[:id])
        render json: commit
      end

      def create
        repo = Repo.find_by(:gh_repo_id => repo_id_param)
        commit = repo.commits.new(:commit_hash => commit_id_param)
        if commit.save
          render json: commit, :status => 201
        else
          render json: commit_errors(commit), :status => 422
        end
      end

      private

      def commit_errors(commit)
        messages = commit.errors.messages
        errors_hash = { "errors" => messages }
      end

      def repo_id_param
        params[:commit][:repository][:id]
      end

      def commit_id_param
        params[:commit][:commit_id]
      end

    end
  end
end
