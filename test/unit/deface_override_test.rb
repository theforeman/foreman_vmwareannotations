require 'test_plugin_helper'

module ForemanVmwareannotations
  class DefaceOverrideTest < ActiveSupport::TestCase
    test 'remove_annotations_field override should be defined' do
      override = Deface::Override.find(virtual_path: 'compute_resources_vms/form/vmware/_base',
                                       name: 'remove_annotations_field')
      
      assert_not_nil override, 'Deface override should be defined'
    end

    test 'remove_annotations_field override should have correct virtual path' do
      override = Deface::Override.find(virtual_path: 'compute_resources_vms/form/vmware/_base',
                                       name: 'remove_annotations_field')
      
      assert_equal 'compute_resources_vms/form/vmware/_base', override.virtual_path
    end

    test 'remove_annotations_field override should remove annotation erb' do
      override = Deface::Override.find(virtual_path: 'compute_resources_vms/form/vmware/_base',
                                       name: 'remove_annotations_field')
      
      assert_equal :remove, override.action
      assert_equal "erb[loud]:contains('annotation')", override.selector
    end

    test 'remove_annotations_field override should have correct name' do
      override = Deface::Override.find(virtual_path: 'compute_resources_vms/form/vmware/_base',
                                       name: 'remove_annotations_field')
      
      assert_equal 'remove_annotations_field', override.name
    end
  end
end
