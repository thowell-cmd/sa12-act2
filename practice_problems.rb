require 'httparty'
require 'json'

response = HTTParty.get('https://api.github.com/users/thowell-cmd/repos')

if response.success?
    repos = JSON.parse(response.body)
    highest_star = nil
    max = 0

    repos.each do |repo|
        num_star = repo['stargazers_count']
        if num_star > max
            max_stars = num_star
            highest_star = repo
        end
    end

    if highest_star
        puts "Most starred repo:"
        puts "Name: #{highest_star['name']}"
        puts "Description: #{highest_star['description']}"
        puts "Star: #{highest_star['star_count']}"
        puts "URL: #{highest_star['html_url']}"
    else
        puts "No repositories"
    end
else
    puts "Error: #{response.code} - #{response.message}"
end