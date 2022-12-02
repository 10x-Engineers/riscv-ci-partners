# Following commands can be used to make sd card bootable with fedora 

# Install virt-builder using following command
sudo apt install libguestfs-tools
# Make sd card bootable with following command
sudo virt-builder \
    --source https://dl.fedoraproject.org/pub/alt/risc-v/repo/virt-builder-images/images/index \
    --no-check-signature \
    --arch riscv64 \
    --format raw \
    --hostname testing.example.com \
    --output /dev/sdXXX \
    --root-password password:riscv \
    fedora-rawhide-developer-20200108.n.0
