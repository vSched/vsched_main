# vSched: Optimizing Task Scheduling in Cloud VMs

![vSched](https://img.shields.io/badge/vSched-Main%20Repo-blue)
![License](https://img.shields.io/badge/License-Apache%202.0-green)

vSched is a novel approach to task scheduling in cloud virtual machines, providing accurate vCPU abstraction and enhancing performance across various VM types. This repository contains everything you need to run and experiment with vSched.

## Important Note

**This is the main repository for vSched.** If you want to run or experiment with vSched, this is the repository you need. It contains all necessary components, including the custom kernel and required userland programs.

## Repository Structure

This repository contains:

- `vsched_kernel/`: A custom Linux kernel with vSched modifications
- `vtopology/`: vTopology prober for vSched
- `vcapacity/`: vCapacity prober for vSched
- `setup_vsched.sh`: Script to install and prepare system for vsched
- `activate_vsched_bpf.sh`: Script to activate IVH and BPF
- `activate_vsched_total.sh`: Ease-of-use script to setup and run vsched directly

### Installing Host Prerequisites and creating a VM
If you already have a VM that you want to use vSched on, skip these steps.

1.Run the following commands on your host system to install virsh and enable creation of VM's

```
sudo apt update
sudo apt install qemu-kvm libvirt-daemon-system
```

2.Use the GUI or follow a guide to create a VM

[https://deploy.equinix.com/developers/guides/kvm-and-libvirt/](https://deploy.equinix.com/developers/guides/kvm-and-libvirt/)

3.Use a GUI, SSH or `virsh console` to access your VM


### Setup and run vSched's Kernel

1.Install prerequisites inside the VM:

```
sudo apt update
sudo apt install -y git build-essential libncurses5-dev bison flex libssl-dev libelf-dev gcc make
```

2.Clone the vSched repository in your VM:

```
git clone [https://github.com/yourusername/vsched.git](https://github.com/vSched/vsched_main.git)
cd vsched
```

3.Compile and install the custom kernel:

```
cd vsched_kernel
cp /boot/config-$(uname -r) .config
make olddefconfig
make -j$(nproc)
sudo make modules_install
sudo make install
sudo update-grub
sudo reboot
```


After reboot, verify you're running the new kernel:

```
uname -r
```

### Running the Probers
1.Run the setup bash script

```
sudo ./setup_vsched.sh
```

2. Check the README in vCapacity and vTopology for more information on how to run and configure each tool individually.

3. If you want to run vcapacity without custom starting parameters

```
sudo ./vcapacity/vcap -v
```

4. If you want to run vtopology without custom starting parameters

```
sudo ./vtopology/vtop 
```

### Running vSched

1. After running the probers, use the bash scripts to enable the rest of vsched:

```
sudo ./activate_vsched_bpf.sh
```

2. If you want to run vSched in it's entirety, this script takes care of all the previous steps except for installing/running the kernel

```
sudo ./activate_vsched_total.sh
```


### Deactivating vSched

1.Run the deactivation script 

```
sudo ./deactivate_vsched.sh
```




