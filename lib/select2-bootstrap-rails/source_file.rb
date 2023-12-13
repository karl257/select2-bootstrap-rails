require "thor"
require "json"
require "httpclient"

class SourceFile < Thor
  include Thor::Actions

  desc "fetch source files", "fetch source files from GitHub"
  def fetch
    filtered_select2_tags = fetch_select2_tags
    select2_tag = select("Which tag do you want to fetch for select2?", filtered_select2_tags)
    bs_theme_tag = select("Which tag do you want to fetch for select 2 bootstrap 5 theme?", fetch_bs_theme_tags)
    self.destination_root = "vendor/assets"
    remote_select2 = "https://github.com/select2/select2"
    remote_bootstrap = "https://github.com/apalfrey/select2-bootstrap-5-theme"
    get "#{remote_select2}/raw/#{select2_tag}/dist/css/select2.css", "stylesheets/select2.css"
    get "#{remote_select2}/raw/#{select2_tag}/dist/js/select2.full.js", "javascripts/select2-full.js"
    get "#{remote_select2}/raw/#{select2_tag}/dist/js/select2.js", "javascripts/select2.js"
    get "#{remote_bootstrap}/raw/#{bs_theme_tag}/dist/select2-bootstrap-5-theme.css", "stylesheets/select2-bootstrap-5-theme.css"
    languages(select2_tag).each do |lang|
      get "#{remote_select2}/raw/#{select2_tag}/dist/js/i18n/#{lang}.js", "javascripts/select2_locale_#{lang}.js"
    end
  end

  private

  def fetch_select2_tags
    response = JSON.parse(http_client.get("https://api.github.com/repos/select2/select2/tags").body)
    response.map { |tag| tag["name"] }.sort
  end

  def fetch_bs_theme_tags
    response = JSON.parse(http_client.get("https://api.github.com/repos/apalfrey/select2-bootstrap-5-theme/tags").body)
    response.map { |tag| tag["name"] }.sort
  end

  def http_client
    @http_client ||= HTTPClient.new
  end

  def languages(tag)
    response = JSON.parse(http_client.get("https://api.github.com/repos/select2/select2/contents/src/js/select2/i18n?ref=#{tag}").body)
    response.map { |file| file["name"].gsub('.js', '') }.sort
  end

  def select(message, elements)
    elements.each_with_index do |element, index|
      say(block_given? ? yield(element, index + 1) : ("#{index + 1}. #{element.to_s}"))
    end
    result = ask(message).to_i
    elements[result - 1]
  end
end
