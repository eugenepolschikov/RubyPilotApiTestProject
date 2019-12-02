require 'rest-client'
require 'json-schema'
require 'yaml'

When(/^I send customized (GET|POST|PATCH|PUT|DELETE) request to "(.*?)"$/) do |method, url|


  arg3 = YAML::load_file(File.join(__dir__, '../../config/env.yml'))


  request_url = URI.encode resolve(arg3['api_url']+url)
  #request_url = URI.encode resolve(arg3['api_url'])

  print "full URL"
  print request_url
  # for debug
  #print request_url
  #print "#1#1"
  #print arg3['api_url']
  #print "#2#2"

  if 'GET' == %/#{method}/ and $cache.has_key? %/#{request_url}/
    @response = $cache[%/#{request_url}/]
    @headers = nil
    @body = nil
    next
  end

  @headers = {} if @headers.nil?
  begin
    case method
    when 'GET'
      response = RestClient.get request_url, @headers
    when 'POST'
      response = RestClient.post request_url, @body, @headers
    when 'PATCH'
      response = RestClient.patch request_url, @body, @headers
    when 'PUT'
      response = RestClient.put request_url, @body, @headers
    else
      response = RestClient.delete request_url, @headers
    end
  rescue RestClient::Exception => e
    response = e.response
  end
  @response = CucumberApi::Response.create response
  @headers = nil
  @body = nil
  $cache[%/#{request_url}/] = @response if 'GET' == %/#{method}/
end