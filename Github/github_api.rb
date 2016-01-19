require 'github_api'
require 'pry-byebug'
require 'figaro'
require 'pp'

Figaro.application = Figaro::Application.new(
  environment: "development",
  path: "config/application.yml"
)
Figaro.load

class GithubAPI
  TOKEN = Figaro.env.GITHUB_API
  USERNAME = Figaro.env.USERNAME

  attr_accessor :client, :repos

  def initialize
    @client = Github.new
    @client.current_options[:oauth_token] = TOKEN
  end

  def get_repos
    @repos = @client.repos.list(sort: "updated").first(10)
  end

  def get_commits
    @names.each do |name|
      @client.repos.commits.list(USERNAME, name)
    end
  end

  def get_name
    @names = @repos.map{|repo| repo['name']}
  end

end

git = GithubAPI.new
# binding.pry
git.get_repos
git.get_name
pp git.get_commits


# git.repos.commit.list(USERNAME, 'assignment_ruby_api_calls')
# pp git.client.repos.commits.list('jgisin', 'assignment_ruby_api_calls')
# binding.pry
# pp git.client.repos.list[0]
# git.get_repos(3)
# pp git.get_commits
# pp git.repos
# git.client.repos.commits.list('jgisin', 'assignment_ruby_api_calls').body[0]['commit']['message']]