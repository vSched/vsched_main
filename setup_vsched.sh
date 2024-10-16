#!/bin/bash

sudo echo "+cpu" | sudo tee /sys/fs/cgroup/cgroup.subtree_control;
sudo echo "+cpuset" | sudo tee /sys/fs/cgroup/cgroup.subtree_control;


if [ ! -d /sys/fs/cgroup/hi_prgroup ]; then
    sudo mkdir /sys/fs/cgroup/hi_prgroup
fi


if [ ! -d /sys/fs/cgroup/lw_prgroup ]; then
    sudo mkdir /sys/fs/cgroup/lw_prgroup
fi


sudo echo "threaded" > /sys/fs/cgroup/lw_prgroup/cgroup.type;
sudo echo "threaded" > /sys/fs/cgroup/hi_prgroup/cgroup.type;
sudo echo 1 | sudo tee /sys/fs/cgroup/lw_prgroup/cpu.idle
sudo echo -20 | sudo tee /sys/fs/cgroup/hi_prgroup/cpu.weight.nice

#sudo make


(cd ./vsched_kernel/vtopology/ && sudo make)

(cd ./vsched_kernel/vcapacity/ && sudo make)

(cd ./vsched_kernel/custom_modules/ && sudo make)

sudo insmod ./vsched_kernel/custom_modules/preempt_proc.ko

(cd ./vsched_kernel/tools/lib/bpf && sudo make)

(cd ./vsched_kernel/tools/bpf/bpftool && sudo make)

sudo bash -c '
cd ./vsched_kernel/tools/bpf/vcfs && 
../bpftool/bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
'

(cd ./vsched_kernel/tools/bpf/vcfs && sudo make)

