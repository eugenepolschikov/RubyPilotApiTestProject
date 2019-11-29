require 'rubygems'
require 'rspec'
require 'watir'

include Selenium

#Creating Remote WebDriver
browser = Watir::Browser.new(:remote, :url => "http://localhost:4444/wd/hub",
                             :desired_capabilities => WebDriver::Remote::Capabilities.firefox)
#browser = Watir::Browser.new :chrome
#If you want to run it locally, use Watir::Browser.new :firefox

Before do
  @browser = browser
end