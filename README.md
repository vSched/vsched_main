# vSched: Optimizing Task Scheduling in Cloud VMs

![vSched](https://img.shields.io/badge/vSched-Main%20Repo-blue)
![License](https://img.shields.io/badge/License-Apache%202.0-green)

vSched is a novel approach to task scheduling in cloud virtual machines, providing accurate vCPU abstraction and enhancing performance across various VM types. This repository contains everything you need to run and experiment with vSched.

## Authors
- Edward Guo (Hofstra University)
- Weiwei Jia (University of Rhode Island)
- Xiaoning Ding (New Jersey Institute of Technology)
- Jianchen Shan (Hofstra University)

All inquiries regarding this project should be directed to Edward, at eguo3@pride.hofstra.edu.

## Important Note

**This is the main repository for vSched.** 
This repository contains all components necessary to run and experiment with vSched, including the custom kernel and userland programs.

⚠️ **vSched is intended for x86 Intel systems**  
vSched is built and tested on an x86 Intel system with Ubuntu. Different configurations are not supported.


## Repository Structure

This repository contains:

- `vsched_kernel/`: A custom Linux kernel with vSched modifications
- `vtopology/`: vTopology prober for vSched
- `vcapacity/`: vCapacity prober for vSched
- `setup_vsched.sh`: Script to install and prepare system for vsched
- `activate_vsched_bpf.sh`: Script to activate IVH and BPF
- `activate_vsched_total.sh`: Ease-of-use script to setup and run vsched directly


## Using vSched

### Installing Host Prerequisites and creating a VM

Skip this section if you already have a suitable VM.



1.Install virsh on your host system:


```
sudo apt update
sudo apt install qemu-kvm libvirt-daemon-system
```

2.Create a VM using the GUI or follow the guide at

[https://deploy.equinix.com/developers/guides/kvm-and-libvirt/](https://deploy.equinix.com/developers/guides/kvm-and-libvirt/)

3.Access your VM via GUI, SSH, or 'virsh console'


### Setup and run vSched's Kernel

⚠️ The following steps should be performed inside your VM, not on the host system. 


1.Install prerequisites:

```
sudo apt update
sudo apt install -y git build-essential libncurses5-dev bison flex libssl-dev libelf-dev gcc make
```

2.Clone the repository:

```
git clone https://github.com/vSched/vsched_main.git
cd vsched_main
```

3.Compile and install:

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

The output should show:
```
6.1.36-vsched
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

1. After running the probers, use the bash scripts to enable the rest of vsched (IVH and BVS):

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






