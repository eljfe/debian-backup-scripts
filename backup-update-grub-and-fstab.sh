#! /bin/bash
# 2024.06

srcdev=/dev/sda3
destdev=/dev/sda2
echo "the source device: ${srcdev}"
echo "& the destination device: ${destdev}"
echo "... if this is not right, that is very bad"
echo "... continue?"
read -p "    [y/n]?   " qua
if [ $qua != "y" ]; then
	echo "not eq: $qua"
	exit 1
fi
echo ""
echo "OK..."
echo ""
echo ""


destgrub=/boot/grub/destination_grub.cfg
echo "--> copying grub to ${destgrub}"
cp /boot/grub/grub.cfg $destgrub

srcdev_uuid=$(blkid ${srcdev} -s UUID -o value)
destdev_uuid=$(blkid ${destdev} -s UUID -o value)
echo "${srcdev}: ${srcdev_uuid}"
echo "${destdev}: ${destdev_uuid}"

echo "--> updating the ${destdev} UUID in ${destgrub}"
sed -i "s/${srcdev_uuid}/${destdev_uuid}/g" $destgrub

# My spare NVME install.
# cp /boot/grub/grub.cfg bin/boot_sp_nvme_grub.cfg
# sed -i "s/766dcfc3-a1e4-495f-86e2-570205723fef/a4410a13-b1ea-4007-b22f-6eb9e0a2ead4/g" /root/bin/boot_sp_nvme_grub.cfg
#
echo "--> done grub copy"
echo ""
echo ""


destfstab=
echo "--> updating de

unset destgrub
unset srcdev
unset destdev
unset srcdev_uuid
unset destdev_uuid
