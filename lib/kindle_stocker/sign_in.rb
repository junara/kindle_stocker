# frozen_string_literal: true

module KindleStocker
  class SignIn
    attr_reader :browser, :email_input_css, :password_input_css, :url, :sign_in_submit_css, :config

    def initialize(browser, lang)
      @config = KindleStocker::Config.new(lang)
      @browser = browser
      @url = config.sign_in[:url]
      @email_input_css = config.sign_in[:email_input_css]
      @password_input_css = config.sign_in[:password_input_css]
      @sign_in_submit_css = config.sign_in[:sign_in_submit_css]
    end

    def sign_in(email, password)
      browser.goto(url)
      sleep(1)
      fill_and_submit(browser, email, password)
      sleep(1)
      wait_for_sign_in(browser)
    end

    def sign_out
      browser.goto(url)
      sleep(1)
      click_sign_out(browser) if sign_in?(browser)
    end

    private

    def sign_in?(browser)
      browser.goto(url) unless sign_in_url?(browser)
      browser.screenshot(path: "./tmp/#{Time.now}.png")

      browser.at_css(config.sign_in[:signed_in_css]).present?
    end

    def sign_in_url?(browser)
      URI.parse(browser.browser.current_url).host == URI.parse(@url).host
    end

    def click_sign_out(browser)
      browser.at_css('#kp-notebook-head > div > div.a-column.a-span3.a-text-right.a-spacing-top-mini.a-span-last > span > a').click
      browser.at_css('#a-popover-content-1 > table > tbody > tr:nth-child(5) > td > a').click
    end

    def fill_and_submit(browser, email, password)
      browser.at_css(email_input_css).focus.type(email)
      browser.at_css(password_input_css).focus.type(password)
      browser.at_css(sign_in_submit_css).click
    end

    def wait_for_sign_in(browser, max_num = 60)
      max_num.times do |i|
        pp "wait #{i} sec (max #{max_num} sec)"
        sleep(1)
        if sign_in?(browser)
          pp 'signed in !'
          break
        end
      end
    end
  end
end
