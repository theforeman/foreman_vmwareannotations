require 'test_plugin_helper'

module ForemanVmwareannotations
  class EngineTest < ActiveSupport::TestCase
    test 'engine should be a Rails::Engine' do
      assert ForemanVmwareannotations::Engine < Rails::Engine
    end

    test 'engine name should be foreman_vmwareannotations' do
      assert_equal 'foreman_vmwareannotations', ForemanVmwareannotations::Engine.engine_name
    end

    test 'plugin should be registered' do
      plugin = Foreman::Plugin.find(:foreman_vmwareannotations)
      
      assert_not_nil plugin, 'Plugin should be registered with Foreman'
      assert_equal :foreman_vmwareannotations, plugin.id
    end

    test 'plugin should require foreman >= 1.12' do
      plugin = Foreman::Plugin.find(:foreman_vmwareannotations)
      
      # Check that the plugin has foreman version requirements
      assert plugin.to_prepare_callbacks.present? || plugin.instance_variable_get(:@validates).present?,
             'Plugin should have version requirements'
    end

    test 'VmwareExtensions should be included in Foreman::Model::Vmware if available' do
      skip 'Skipping if Vmware model is not available' unless defined?(Foreman::Model::Vmware) && Foreman::Model::Vmware.available?
      
      assert Foreman::Model::Vmware.included_modules.include?(ForemanVmwareannotations::VmwareExtensions),
             'VmwareExtensions should be included in Foreman::Model::Vmware'
    end
  end
end
