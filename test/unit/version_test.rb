require 'test_plugin_helper'

module ForemanVmwareannotations
  class VersionTest < ActiveSupport::TestCase
    test 'version constant should be defined' do
      assert_not_nil ForemanVmwareannotations::VERSION
    end

    test 'version should be a string' do
      assert_kind_of String, ForemanVmwareannotations::VERSION
    end

    test 'version should match semantic versioning format' do
      # Version should be in format X.Y.Z or X.Y.Z.suffix
      assert_match /\A\d+\.\d+\.\d+/, ForemanVmwareannotations::VERSION,
                   'Version should follow semantic versioning'
    end
  end
end
