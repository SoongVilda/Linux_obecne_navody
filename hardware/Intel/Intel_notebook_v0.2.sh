#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Prosím, spusť script se sudo"
  exit 1
fi

#Intel ovladače + Mesa + Vulkan
pacman -S --needed intel-ucode vulkan-intel intel-compute-runtime intel-gmmlib intel-gpu-tools intel-graphics-compiler intel-media-driver intel-media-sdk libmfx libva-utils lib32-vulkan-intel glu libva-mesa-driver mesa mesa-demos mesa-utils mesa-vdpau vulkan-mesa-layers lib32-glu lib32-libva-mesa-driver lib32-mesa lib32-mesa-demos lib32-mesa-utils lib32-mesa-vdpau lib32-vulkan-mesa-layers vulkan-icd-loader vulkan-extra-layers vulkan-extra-tools vulkan-headers

#Přidání modulu i915 a intel_agp
grep -i -q "MODULES=" /etc/mkinitcpio.conf
if [ "$?" -eq 0 ]; then
    sed -i 's/MODULES=()/MODULES=(i915 intel_agp)/g' /etc/mkinitcpio.conf
else
    sed -i 's/MODULES=""/MODULES="i915 intel_agp"/g' /etc/mkinitcpio.conf
fi

#Aktivace GuC a HuC firmware
echo "options i915 enable_guc=2" > /etc/modprobe.d/i915.conf
#Aktivace framebuffer compression
echo "options i915 enable_fbc=1" >> /etc/modprobe.d/i915.conf
#Intel fastboot
echo "options i915 fastboot=1" >> /etc/modprobe.d/i915.conf

#Mesa podpora výkonného režimu
echo "dev.i915.perf_stream_paranoid=0" > /etc/sysctl.d/99-i915.conf

#Načtení sysctl pravidel
sysctl --system

#Znovu vytvoření obrazu kernelu
mkinitcpio -P
