# frozen_string_literal: true

module KindleStocker
  class Books
    attr_reader :browser, :base_url, :collection

    def initialize
      @collection = []
    end

    def load(browser, lang)
      @collection = []
      config = KindleStocker::Config.new(lang)

      browser.goto(config.books[:url])
      sleep(1)
      nodes = browser.css(config.books[:books_css])
      sleep(1)
      return nil if nodes.nil?

      nodes.map do |node|
        book = KindleStocker::Book.new
        book.assign_params(
          asin: node.attribute(config.books[:book][:asin_css]),
          title: node.at_css(config.books[:book][:title_css])&.text,
          authors: node.at_css(config.books[:book][:authors_css])&.text
        )
        add_book(book)
      end
    end

    def add_book(book)
      raise 'Only KindleStocker::Book' unless book.is_a?(KindleStocker::Book)

      @collection << book
    end
  end
end
