Given(/^I launch http:\/\/www\.codoid\.com$/) do
  @LoginPage = LoginPage.new(@browser)
  @LoginPage.visit
end

And(/^I click on Login tab$/) do
  @LoginPage.clickLoginTab
end

And(/^I enter username$/) do
  @LoginPage.enterUsername("xxxxxxx")
end

And(/^I enter password$/) do
  @LoginPage.enterPassword("yyyyyyy")
end

When(/^I click Login button$/) do
  @LoginPage.clickLoginButton
end

Then(/^I see Home page$/) do
  @LoginPage.verifyHomePageHeader
end


Given(/^I launch http:\/\/codoid\.com$/) do
  @LoginPage = LoginPage.new(@browser)
  @LoginPage.visit
end