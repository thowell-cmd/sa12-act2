require 'httparty'
require 'json'

def get_most_starred_repo(username)
  url = "https://api.github.com/users/#{username}/repos"
  response = HTTParty.get(url)
  repos = JSON.parse(response.body)
