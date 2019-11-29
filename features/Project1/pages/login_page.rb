class LoginPage
  attr_accessor :loginTab,:txtUsername,:txtPassword,:btnLogin

  def initialize(browser)
    @browser = browser
    @loginTab    = @browser.a(:text => "Login")
    @txtUsername = @browser.text_field(:id => "userId")
    @txtPassword = @browser.text_field(:id => "password")
    @btnLogin      = @browser.element(:id => "log_in_button")
  end

  def visit
    @browser.goto "https://codoid.com"
  end

  def clickLoginTab()
    @loginTab.click
  end

  def enterUsername(username)
    @txtUsername.set username
  end

  def enterPassword(password)
    @txtPassword.set password
  end

  def clickLoginButton
    @btnLogin.click
  end

  def verifyHomePageHeader()
    @browser.element(:text => "Dashboard").wait_until_present
  end
end