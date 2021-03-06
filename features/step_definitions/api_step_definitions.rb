require 'cucumber-api/response'
require 'cucumber-api/helpers'
require 'rest-client'
require 'json-schema'
require 'yaml'
require 'faker'

$memory = {}

Given(/^I set Headers:$/) do |params|
  arg = YAML::load_file(File.join(__dir__, '../../config/env.yml'))
  params.rows_hash.each do |key, value|
    if value.include? 'GLOBAL:' and $memory.has_key? "#{value.sub! 'GLOBAL:', ''}"
      @headers[key.to_sym] = resolve($memory["#{value}"].to_s)
    else
      unless arg[value].nil?
        @headers[key.to_sym] = resolve(arg[value].to_s)
      else
        @headers[key.to_sym] = resolve(value)
        puts "Enable to get #{value} from env.yml. Current step use hardcoded value."
      end
    end
  end
end

When "I set key {string} with value {string} to body" do |key, value|
  @body[%/#{key}/] = value
end

When "I set key {string} with value {string} from config to body" do |key, value|
  arg = YAML::load_file(File.join(__dir__, '../../config/env.yml'))
  unless arg[value].nil?
    @body[%/#{key}/] = arg[value].to_s
  else
    raise "Unable to get value [#{value}] from env.yml."
  end
end

When "I set key {string} with email {email} to body" do |key, email|
  @body[%/#{key}/] = email
end

When "I set key {string} with first_name {first_name} to body" do |key, first_name|
  @body[%/#{key}/] = first_name
end

When "I set key {string} with last_name {last_name} to body" do |key, last_name|
  @body[%/#{key}/] = last_name
end

When "I set key {string} with phone_number {phone_number} to body" do |key, phone_number|
  @body[%/#{key}/] = phone_number
end

When "I set object {string} key {string} with phone_number {phone_number} to body" do |object, key, phone_number|
  @body[%/#{object}/][%/#{key}/] = phone_number
end

When(/^I send (GET|POST|PATCH|PUT|DELETE) request to endpoint "(.*?)"$/) do |method, url|
  arg1 = YAML::load_file(File.join(__dir__, '../../config/env.yml'))
  request_url = URI.encode resolve(arg1['api_url'] + '/api/v1/' + url)

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
      puts @body
      response = RestClient.post request_url, @body, @headers
    when 'PATCH'
      puts @body
      response = RestClient.patch request_url, @body, @headers
    when 'PUT'
      puts @body
      response = RestClient.put request_url, @body, @headers
    else
      response = RestClient.delete request_url, @headers
    end
  rescue RestClient::Exception => e
    response = e.response
    puts response
  end
  @response = CucumberApi::Response.create response
  @headers = nil
  @body = nil
  $cache[%/#{request_url}/] = @response if 'GET' == %/#{method}/
end

When "I grab {string} as {string} globally" do |k, v|
  if @response.nil?
    raise 'No response found.'
  end

  k = "$.#{k}" unless k[0] == '$'
  $memory = { v => @response.get(k) }
  end

#@TODO re-work that in order to post response in HTML report
When "I grab {string} as {string} globally DUMP RESPONSE" do |k, v|
  if @response.nil?
    raise 'No response found.'
  end

  k = "$.#{k}" unless k[0] == '$'
  $memory = { v => @response.get(k) }
  puts @response
end