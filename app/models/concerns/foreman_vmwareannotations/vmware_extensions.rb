module ForemanVmwareannotations
  module VmwareExtensions
    extend ActiveSupport::Concern

    def host_compute_attrs(host)
      super(host).merge(:annotation => host.comment)
    end
  end
end
