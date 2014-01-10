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
    repo = Repo.find(params[:repo_id])
    commit = repo.commits.new(params[:commit])
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

end
