#
# set vmware workstation version fact
#
Facter.add('vmware_workstation_version') do
  setcode do
    begin
      vmware_product_list = Facter::Core::Execution.execute('vmware-installer -l')
      vmware_workstation = %r{vmware-workstation.*}.match(vmware_product_list).to_s
      %r{[0-9.]+}.match(vmware_workstation).to_s
    rescue
      nil
    end
  end
end
