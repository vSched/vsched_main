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
- `setup_vprobers`: Script to set up vSched probers
- `vsched-full`: Script to run the full vSched system
- Documentation and additional scripts

### Installing Prerequisites

Run the following commands on your host system to install virsh and enable creation of VM's

sudo apt update
sudo apt install qemu-kvm libvirt-daemon-system

Then, create a VM that you plan to run vSched on - if you want to run vsched on an existing VM, skip this step

### Setup vSched

1.Update the package list and install prerequisites inside the VM:

sudo apt update
sudo apt install -y git build-essential libncurses5-dev bison flex libssl-dev libelf-dev gcc make

2.Clone the vSched repository in your VM:

git clone [https://github.com/yourusername/vsched.git](https://github.com/vSched/vsched_main.git)
cd vsched

3.Compile and install the custom kernel:

cd vsched_kernel
cp /boot/config-$(uname -r) .config
make olddefconfig
make -j$(nproc)
sudo make modules_install
sudo make install
sudo update-grub
sudo reboot

After reboot, verify you're running the new kernel:

uname -r

### Running the Probers
1.Run the setup bash script
sudo ./setup_vsched.sh

2.To run vCapacity 








