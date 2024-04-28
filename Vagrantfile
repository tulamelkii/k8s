# -*- mode: ruby -*-
# vim: set ft=ruby

MACHINES = {

:k8s => {
        :box_name => "tulamelkii/VDebian12",
        :box_version => "12.2.7",
        :vm_name => "control",
        :vm_mem => 4000,
        :cpu => 2,
        :net => [
          {ip: '192.168.2.4', adapter: 2, netmask: "255.255.255.240"},
          {ip: '192.168.56.11', adapter: 4},

                ]
 },

:k8s_w => {
        :box_name => "tulamelkii/VDebian12",
        :box_version => "12.2.7",
        :vm_name => "worker",
        :vm_mem => 4000,
        :cpu => 2,
        :net => [
          {ip: '192.168.2.5', adapter: 3, netmask: "255.255.255.240"},
          {ip: '192.168.56.12', adapter: 4},

                ]
 },

:k8s_w2 => {
        :box_name => "tulamelkii/VDebian12",
        :box_version => "12.2.7",
        :vm_name => "worker2",
        :vm_mem => 4000,
        :cpu => 2,
        :net => [
        {ip: '192.168.2.6', adapter: 3, netmask: "255.255.255.240"},
        {ip: '192.168.56.13', adapter: 4},

                ]
 },


}
Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|
    
    config.vm.define boxname do |box|
   
      box.vm.box = boxconfig[:box_name]
      box.vm.host_name = boxconfig[:vm_name]
      box.vm.box_version = boxconfig[:box_version]
      boxconfig[:net].each do |ipconf|
      box.vm.network "private_network", ip: ipconf[:ip], virtualbox__intnet: ipconf[:virtualbox__intnet], netmask: ipconf[:netmask], adapter: ipconf[:adapter]
      end
       box.vm.provider :virtualbox do |v|
        v.memory = boxconfig[:vm_mem]
        v.cpus = boxconfig[:cpu]
        v.customize ['modifyvm', :id, '--nested-hw-virt', 'on']
        v.customize ["modifyvm", :id, "--vram", "128"]        
        v.customize ["modifyvm", :id, "--accelerate3d", "on"]
      end

  
    end
  end
end

