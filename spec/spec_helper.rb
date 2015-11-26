require 'pry'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

RSpec.configure do |config|

  config.color = true
  config.tty = true
  config.formatter = :documentation

end
