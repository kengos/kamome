# frozen_string_literal: true

require 'bundler/setup'
require 'kamome'
require 'support/vcr'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = 'spec/.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  require 'support/path_helper'
  config.include ::PathHelper

  config.before(:all) do
    FileUtils.mkdir_p(tmp_path)
  end

  config.after(:all) do
    FileUtils.rm_r(tmp_path)
  end
end
