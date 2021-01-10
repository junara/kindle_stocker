# frozen_string_literal: true

require 'forwardable'
require 'ferrum'

require_relative 'sign_in'

module KindleStocker
  class Browser
    extend Forwardable
    delegate %i[goto at_css screenshot cookies css] => :browser
    attr_reader :browser

    def initialize(browser_path: nil, system: :mac)
      config_path = KindleStocker::Config.new.yaml[:google_chrome][:path]
      @browser = Ferrum::Browser.new(
        browser_path: browser_path || browser_path_by_system(system, config_path),
        browser_options: { 'no-sandbox': nil } # active only docker env
      )
    end

    private

    def browser_path_by_system(system, config_path)
      case system.to_sym
      when :mac_os, :mac, :macos, :apple
        config_path[:mac]
      when :ubuntu, :linux
        config_path[:linux]
      end
    end
  end
end
