# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, 'https://api.github.com/search/repositories?page=1&per_page=10&q=ruby')
      .with(
        headers: {
          'Content-Type' => 'application/json',
          'User-Agent' => 'Octokit Ruby Gem 4.18.0'
        }
      )
      .to_return(status: 200,
                 body: IO.read(Rails.root.join('spec', 'support', 'response', 'search.txt')),
                 headers: { 'Content-Type' => 'application/json' })

    stub_request(:get, 'https://api.github.com/search/repositories?page=1&per_page=3&q=ruby')
      .with(
        headers: {
          'Accept' => 'application/vnd.github.v3+json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type' => 'application/json',
          'User-Agent' => 'Octokit Ruby Gem 4.18.0'
        }
      )
      .to_return(status: 200,
                 body: IO.read(Rails.root.join('spec', 'support', 'response', 'search 3_items.txt')),
                 headers: { 'Content-Type' => 'application/json' })

    stub_request(:get, 'https://api.github.com/search/repositories?page=2&per_page=10&q=ruby')
      .with(
        headers: {
          'Accept' => 'application/vnd.github.v3+json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type' => 'application/json',
          'User-Agent' => 'Octokit Ruby Gem 4.18.0'
        }
      )
      .to_return(status: 200,
                 body: IO.read(Rails.root.join('spec', 'support', 'response', 'search_pagination.txt')),
                 headers: { 'Content-Type' => 'application/json' })
  end
end
