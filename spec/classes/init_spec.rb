require 'spec_helper'
describe 'vmware_workstation' do
  context 'default parameters' do
    let(:facts) { { architecture: 'x86_64', kernel: 'Linux', memorysize_mb: '2000.00' } }

    it { is_expected.to contain_class('vmware_workstation') }
    it { is_expected.to compile }
    it { is_expected.to contain_archive('vmware_workstation') }
    it { is_expected.to contain_exec('install_workstation') }
  end

  # Can't seem to get this test to work for a warning.
  # context 'has less than required memory' do
  #  let(:facts) { {:architecture => 'x86_64', :kernel => 'Linux', :memorysize_mb => '1000.00'} }
  #  it do
  #     expect {
  #       should compile
  #     }.to raise_error(Puppet::Warning, /VMware Workstation requires at least 2GB of memory./)
  #   end
  # end

  context 'architecture not 64bit' do
    let(:facts) { { architecture: 'i386', kernel: 'Linux', memorysize_mb: '2000.00' } }

    it do
      expect {
        is_expected.to compile
      }.to raise_error(%r{VMware Workstation requires a 64-bit operating system.})
    end
  end

  context 'parameter ensure absent' do
    let(:facts) { { architecture: 'x86_64', kernel: 'Linux', memorysize_mb: '2000.00' } }
    let(:params) { { ensure: 'absent' } }

    it { is_expected.to contain_class('vmware_workstation') }
    it { is_expected.to compile }
    it { is_expected.to contain_exec('uninstall_workstation') }
  end

  context 'parameter neither installed nor absent' do
    let(:facts) { { architecture: 'x86_64', kernel: 'Linux', memorysize_mb: '2000.00' } }
    let(:params) { { ensure: 'ipsum' } }

    it do
      expect {
        is_expected.to compile
      }.to raise_error(%r{Action unknown. VMware Workstation can be installed or absent})
    end
  end
end
