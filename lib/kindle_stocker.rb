# frozen_string_literal: true

require_relative 'kindle_stocker/version'
require_relative 'kindle_stocker/sign_in'
require_relative 'kindle_stocker/browser'
require_relative 'kindle_stocker/config'
require_relative 'kindle_stocker/base'
require_relative 'kindle_stocker/books'
require_relative 'kindle_stocker/book'
require_relative 'kindle_stocker/highlight'

module KindleStocker
  class Error < StandardError; end
end
