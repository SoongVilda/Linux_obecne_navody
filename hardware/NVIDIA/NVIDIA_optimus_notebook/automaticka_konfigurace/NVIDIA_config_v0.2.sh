#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Prosím, spusť script se sudo"
  exit 1
fi

#Instalace NVIDIA ovladačů.
pacman -S --needed egl-wayland libvdpau libxnvctrl nvidia-dkms nvidia-settings nvidia-utils opencl-nvidia cuda lib32-libvdpau lib32-nvidia-utils lib32-opencl-nvidia vulkan-icd-loader lib32-vulkan-icd-loader

#Hardwareově akcelerovaný video encoding s NVENC.
echo 'ACTION=="add", DEVPATH=="/bus/pci/drivers/nvidia", RUN+="/usr/bin/nvidia-modprobe -c0 -u"' > /etc/udev/rules.d/70-nvidia.rules

#PCI-Express Runtime D3 (RTD3) Power Management.
echo '# Remove NVIDIA USB xHCI Host Controller devices, if present
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{remove}="1"

# Remove NVIDIA USB Type-C UCSI devices, if present
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{remove}="1"

# Remove NVIDIA Audio devices, if present
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{remove}="1"

# Enable runtime PM for NVIDIA VGA/3D controller devices on driver bind
ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="auto"
ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="auto"

# Disable runtime PM for NVIDIA VGA/3D controller devices on driver unbind
ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="on"
ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="on"' > /etc/udev/rules.d/80-nvidia-pm.rules

#Dynamic power management
echo 'options nvidia "NVreg_DynamicPowerManagement=0x02"' > /etc/modprobe.d/nvidia-pm.conf

#Povolí službu nvidia-persistenced, aby jádro nezrušilo stav zařízení, kdykoli se prostředky zařízení NVIDIA již nepoužívají.
systemctl enable nvidia-persistenced
systemctl start nvidia-persistenced

#Znovu vytovření obrazu kernelu.
mkinitcpio -P

#Načtení nových pravidel.
udevadm control --reload
udevadm trigger