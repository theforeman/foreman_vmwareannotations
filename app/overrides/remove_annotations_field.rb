Deface::Override.new(
  :name => 'remove_annotations_field',
  :virtual_path => 'app/views/compute_resources_vms/form/vmware/_base',
  :remove => "#host_compute_attributes_annotation"
)
