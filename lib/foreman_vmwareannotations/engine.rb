require 'deface'

module ForemanVmwareannotations
  class Engine < ::Rails::Engine
    engine_name 'foreman_vmwareannotations'

    initializer 'foreman_vmwareannotations.register_plugin', :before => :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_vmwareannotations do
        requires_foreman '>= 1.12'
      end
    end

    config.to_prepare do
      begin
        Foreman::Model::Vmware.send(:include, ForemanVmwareannotations::VmwareExtensions) if Foreman::Model::Vmware.available?
      rescue => e
        puts "#{ForemanVmwareannotations::ENGINE_NAME}: skipping engine hook (#{e.to_s})"
      end
    end
  end
end
