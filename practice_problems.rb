require 'httparty'
require 'json'

def get_max_starred_repo(username)
  url = "https://api.github.com/users/#{username}/repos"
  puts url
  response = HTTParty.get(url)
  repos = JSON.parse(response.body)

  max = 0
  max_starred_repo = nil

  repos.each do |repo|
    name = repo['name']
    description = repo['description']
    num_stars = repo['stargazers_count']
    url = repo['html_url']

    if num_stars > max
      max = num_stars
      max_starred_repo = { name: name, description: description, stars: stars, url: url }
    end
  end

  max_starred_repo
end


username = 'thowell-cmd'
max_starred_repo = get_max_starred_repo(username)

if max_starred_repo
  puts "Most Starred Repository:"
  puts "Name: #{max_starred_repo[:name]}"
  puts "Description: #{max_starred_repo[:description]}"
  puts "Stars: #{max_starred_repo[:stars]}"
  puts "URL: #{max_starred_repo[:url]}"
else
  puts "No repositories found for the given username."
end
