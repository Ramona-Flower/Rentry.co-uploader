require 'net/http'
require 'uri'
require 'json'

def create_rentry_paste(text, custom_url = "", edit_code = "")
  url = URI.parse("https://rentry.co")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  response = http.get("/")
  csrf_token = response.response['set-cookie'][/csrftoken=([^;]+)/, 1]
  post_url = URI.parse("https://rentry.co/api/new")
  request = Net::HTTP::Post.new(post_url)
  request["Cookie"] = "csrftoken=#{csrf_token}"
  request["Referer"] = url.to_s
  request.set_form_data({
    "csrfmiddlewaretoken" => csrf_token,
    "text" => text,
    "metadata" => "",
    "edit_code" => edit_code,
    "url" => custom_url
  })
  post_response = http.request(request)
  result = JSON.parse(post_response.body)
  {
    "paste_url" => result["url"],
    "short_url" => result["url_short"],
    "edit_code" => result["edit_code"]
  }
end

puts create_rentry_paste("Hello custom!", "Ramona", "Ramona")
