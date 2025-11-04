require 'test_plugin_helper'

module ForemanVmwareannotations
  class VmwareExtensionsTest < ActiveSupport::TestCase
    setup do
      # Create a mock VMware compute resource with the extension included
      @compute_resource = Class.new do
        include ForemanVmwareannotations::VmwareExtensions
        
        # Mock the parent class method
        def host_compute_attrs(host)
          { :cpus => 2, :memory => 4096 }
        end
      end.new
    end

    test 'host_compute_attrs should merge annotation from host comment' do
      host = mock('host')
      host.stubs(:comment).returns('This is a test comment')
      
      result = @compute_resource.host_compute_attrs(host)
      
      assert_equal 'This is a test comment', result[:annotation]
      assert_equal 2, result[:cpus]
      assert_equal 4096, result[:memory]
    end

    test 'host_compute_attrs should handle nil comment' do
      host = mock('host')
      host.stubs(:comment).returns(nil)
      
      result = @compute_resource.host_compute_attrs(host)
      
      assert_nil result[:annotation]
    end

    test 'host_compute_attrs should handle empty comment' do
      host = mock('host')
      host.stubs(:comment).returns('')
      
      result = @compute_resource.host_compute_attrs(host)
      
      assert_equal '', result[:annotation]
    end

    test 'host_compute_attrs should merge annotation with existing attributes' do
      host = mock('host')
      host.stubs(:comment).returns('Production server - do not delete')
      
      result = @compute_resource.host_compute_attrs(host)
      
      assert_equal 'Production server - do not delete', result[:annotation]
      assert result.key?(:cpus), 'Should preserve existing cpus attribute'
      assert result.key?(:memory), 'Should preserve existing memory attribute'
    end

    test 'host_compute_attrs should handle special characters in comment' do
      host = mock('host')
      host.stubs(:comment).returns("Test\nwith\nnewlines\nand\ttabs")
      
      result = @compute_resource.host_compute_attrs(host)
      
      assert_equal "Test\nwith\nnewlines\nand\ttabs", result[:annotation]
    end

    test 'host_compute_attrs should handle unicode characters in comment' do
      host = mock('host')
      host.stubs(:comment).returns('Server with unicode: 日本語 中文 한국어')
      
      result = @compute_resource.host_compute_attrs(host)
      
      assert_equal 'Server with unicode: 日本語 中文 한국어', result[:annotation]
    end
  end
end
