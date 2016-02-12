scripts_dir = "./scripts"

Vagrant.configure("2") do |config|
  config.vm.define :controller do |c|
    c.vm.box = "vivid_cloudimg64"
    c.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/vivid/current/vivid-server-cloudimg-amd64-vagrant-disk1.box"
    c.ssh.forward_agent = true
    c.vm.synced_folder "~/", "/mnt/shared_home"
    c.vm.network "private_network", ip: "192.168.175.100"
    c.vm.hostname = "controller"
    c.vm.provision :shell, :path => File.join(scripts_dir, "install_docker.sh")
    c.vm.provision :shell, :path => File.join(scripts_dir, "install_kubernetes.sh")
    c.vm.provision :shell, :path => File.join(scripts_dir, "etcd.sh")
    c.vm.provision :shell, :path => File.join(scripts_dir, "install_flanneld.sh"), :args => "controller"
    c.vm.provision :shell, :path => File.join(scripts_dir, "docker_flannel_setup.sh"), :args => "controller"
    c.vm.provision :shell, :path => File.join(scripts_dir, "kube_services.sh"), :args => "controller"
    c.vm.provision :file, source: "./kube_examples/", destination: "./kube_examples/"
  end

  (2..4).each do |n|
    config.vm.define "worker#{n}".to_sym do |c|
      c.vm.box = "vivid_cloudimg64"
      c.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/vivid/current/vivid-server-cloudimg-amd64-vagrant-disk1.box"
      c.ssh.forward_agent = true
      c.vm.synced_folder "~/", "/mnt/shared_home"
      c.vm.network "private_network", ip: "192.168.175.#{n}"
      c.vm.hostname = "worker#{n}"
      c.vm.provision :shell, :path => File.join(scripts_dir, "install_docker.sh")
      c.vm.provision :shell, :path => File.join(scripts_dir, "install_kubernetes.sh")
      c.vm.provision :shell, :path => File.join(scripts_dir, "install_flanneld.sh")
      c.vm.provision :shell, :path => File.join(scripts_dir, "docker_flannel_setup.sh")
      c.vm.provision :shell, :path => File.join(scripts_dir, "kube_services.sh")
    end
  end
end
