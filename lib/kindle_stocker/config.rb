# frozen_string_literal: true

require 'yaml'
require 'active_support/all'

module KindleStocker
  class Config
    extend Forwardable

    attr_reader :yaml

    def initialize(lang = 'ja')
      common_hash = HashWithIndifferentAccess.new(YAML.load_file(File.join(__dir__, 'config', common_filename)))
      custom_hash = HashWithIndifferentAccess.new(YAML.load_file(File.join(__dir__, 'config',
                                                                           custom_filename(lang.to_s))))
      @yaml = common_hash.deep_merge(custom_hash)
    end

    def sign_in
      yaml[:sign_in]
    end

    def book
      yaml[:book]
    end

    def books
      yaml[:books]
    end

    private

    def common_filename
      'common.yml'
    end

    def custom_filename(lang)
      "#{lang}.yml"
    end
  end
end
