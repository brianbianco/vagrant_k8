scripts_dir = "./scripts"

Vagrant.configure("2") do |config|
  config.vm.define :controller do |c|
    c.vm.box = "vivid_cloudimg64"
    c.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/vivid/current/vivid-server-cloudimg-amd64-vagrant-disk1.box"
    c.ssh.forward_agent = true
    c.vm.synced_folder "~/", "/mnt/shared_home"
    c.vm.network "private_network", ip: "192.168.175.100"
    c.vm.hostname = "controller"
    c.vm.provision :shell, :path => File.join(scripts_dir, "install_consul.sh")
    c.vm.provision :shell, :path => File.join(scripts_dir, "consul_server.sh")
    c.vm.provision :shell, :path => File.join(scripts_dir, "install_docker.sh")
    c.vm.provision :shell, :path => File.join(scripts_dir, "docker_overlay.sh")
  end

  (2..4).each do |n|
    config.vm.define "worker#{n}".to_sym do |c|
      c.vm.box = "vivid_cloudimg64"
      c.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/vivid/current/vivid-server-cloudimg-amd64-vagrant-disk1.box"
      c.ssh.forward_agent = true
      c.vm.synced_folder "~/", "/mnt/shared_home"
      c.vm.network "private_network", ip: "192.168.175.#{n}"
      c.vm.hostname = "worker#{n}"
      c.vm.provision :shell, :path => File.join(scripts_dir, "install_consul.sh")
      c.vm.provision :shell, :path => File.join(scripts_dir, "consul_agent.sh")
      c.vm.provision :shell, :path => File.join(scripts_dir, "install_docker.sh")
      c.vm.provision :shell, :path => File.join(scripts_dir, "docker_overlay.sh")
    end
  end
end
