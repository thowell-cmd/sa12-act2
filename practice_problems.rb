require 'httparty'
require 'json'

#Practice prob 1
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


puts ' '
########################################################
#Practice prob 2

response = HTTParty.get('https://api.coingecko.com/api/v3/coins/markets?vs_curr
ency=usd')

if response.success?
    crypto = JSON.parse(response.body)

    sort_crypto = crypto.sort_by { |c| -c['market_cap'] }

    sort_crypto.take(5).each do |c|
        puts "Name: #{c['name']}"
        puts "Current Price: #{c['current_price']}"
        puts "Market Capitalization: #{c['market_cap']}"
        puts " "
    end
else
    puts "Error: #{response.code} - #{response.message}"
end

##########################################################
#Practice prob 3


response = HTTParty.get('http://worldtimeapi.org/api/timezone/Europe/London')

if response.success?
    response_data = JSON.parse(response.body)
    date = response_data['datetime']  #.split('T').first
    time = response_data['datetime']  #.split('T').last.split('.').first

    puts "Current time in London Europe is #{date} #{time}"

else
    puts "Error: #{response.code} - #{response.message}"

end