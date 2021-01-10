# frozen_string_literal: true

module KindleStocker
  class Book
    attr_accessor :asin, :img_src, :title, :authors, :last_accessed_date, :highlights

    def initialize
      @highlights = []
    end

    def assign_params(asin:, img_src: nil, title: nil, authors: nil, last_accessed_date: nil)
      @asin = asin
      @img_src = img_src
      @title = title
      @authors = authors
      @last_accessed_date = last_accessed_date
    end

    def load(browser, lang)
      sleep(0.5)
      load_book(browser, lang)
      sleep(0.5)
      load_highlights(browser, lang)
    end

    def book_url(asin, base_url)
      base_url + URI.encode_www_form([['asin', asin], ['contentLimitState', '']])
    end

    def add_highlight(highlight)
      @highlights << highlight
    end

    private

    def load_book(browser, lang)
      config = KindleStocker::Config.new(lang)
      base_url = config.book[:base_url]
      browser.goto(book_url(@asin, base_url))
      assign_params(
        asin: @asin,
        img_src: browser.at_css('img')&.attribute('src'),
        title: browser.at_css('h3.kp-notebook-metadata')&.text,
        authors: browser.at_css('p.a-spacing-none.a-spacing-top-micro.a-size-base.a-color-secondary.kp-notebook-selectable.kp-notebook-metadata')&.text
      )
    end

    def load_highlights(browser, lang)
      config = KindleStocker::Config.new(lang)
      base_url = config.book[:base_url]
      browser.goto(book_url(@asin, base_url))

      nodes = browser.at_css('#kp-notebook-annotations').css('div.a-row.a-spacing-base')
      nodes.each do |node|
        highlight = KindleStocker::Highlight.new(
          id: node.attribute('id'),
          highlight: node.at_css('#highlight')&.text,
          note: node.at_css('#note')&.text
        )
        add_highlight(highlight)
      end
    end
  end
end
