require 'test_plugin_helper'

module ForemanVmwareannotations
  class IntegrationTest < ActiveSupport::TestCase
    setup do
      skip 'VMware integration tests require Foreman::Model::Vmware' unless defined?(Foreman::Model::Vmware)
      skip 'VMware model is not available' unless Foreman::Model::Vmware.available?
    end

    test 'Vmware compute resource should include VmwareExtensions' do
      assert Foreman::Model::Vmware.included_modules.include?(ForemanVmwareannotations::VmwareExtensions),
             'Foreman::Model::Vmware should include VmwareExtensions'
    end

    test 'Vmware compute resource should respond to host_compute_attrs' do
      # This test verifies the method is available but doesn't test the actual VMware connection
      assert Foreman::Model::Vmware.instance_methods.include?(:host_compute_attrs),
             'Vmware should respond to host_compute_attrs'
    end
  end
end
