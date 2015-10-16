Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :shell, path: "Vagrant_provision.sh"
#  config.vm.network "private_network", ip: "192.168.13.37"
  config.vm.network :forwarded_port, host: 8080, guest: 8080
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end
end
