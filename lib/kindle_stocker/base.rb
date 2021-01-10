# frozen_string_literal: true

require 'forwardable'
module KindleStocker
  class Base
    extend Forwardable
    delegate %i[sign_in sign_out] => :sign_in_browser
    attr_reader :browser, :sign_in_browser, :lang

    def initialize(browser_path: nil, system: :mac, lang: :ja)
      @browser = KindleStocker::Browser.new(browser_path: browser_path, system: system)
      @sign_in_browser = KindleStocker::SignIn.new(@browser, lang)
      @kindle_stocker_books = KindleStocker::Books.new
      @lang = lang
    end

    def cache_clear
      browser.cookies.clear
    end

    def load_books
      pp "Start loading highlighted book list at #{Time.now}"

      @kindle_stocker_books.load(@browser, @lang)
      pp "End loading highlighted book list at #{Time.now}"
    end

    def load_highlights
      pp "Start loading highlights for each books at #{Time.now}"
      @kindle_stocker_books.collection.each do |book|
        pp "Getting #{book.asin} #{book.title} highlights at #{Time.now}"
        book.load(@browser, @lang)
      end
      pp "End loading highlights for each books at #{Time.now}"
    end

    def books
      @kindle_stocker_books.collection
    end
  end
end
