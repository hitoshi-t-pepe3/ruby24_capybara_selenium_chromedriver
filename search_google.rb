#! /usr/bin/env ruby

require "capybara"
require "selenium-webdriver"

Capybara.current_driver = :selenium

# Chrome
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

module Crowler
  class Google
    include Capybara::DSL

    def hit_num keyword

      visit URI.escape("https://www.google.co.jp/search?q=" + keyword)

      result_status = all("#resultStats")[0]
      unless result_status.nil?
        result_status.text.match(/(\d+,)*\d+/)[0].gsub(",","").to_i
      else
        0
      end
    end

  end
end

blowser = Crowler::Google.new
print blowser.hit_num "Capybara Selenium"
