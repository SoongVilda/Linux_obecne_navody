#!/bin/bash

pacman -S --needed extra/intel-ucode extra/vulkan-intel community/intel-compute-runtime community/intel-gmmlib community/intel-gpu-tools community/intel-graphics-compiler community/intel-media-driver community/intel-media-sdk community/libmfx community/libva-utils multilib/lib32-vulkan-intel extra/glu extra/libva-mesa-driver extra/mesa extra/mesa-demos extra/mesa-utils extra/mesa-vdpau extra/vulkan-intel extra/vulkan-mesa-layers multilib/lib32-glu multilib/lib32-libva-mesa-driver multilib/lib32-mesa multilib/lib32-mesa-demos multilib/lib32-mesa-utils multilib/lib32-mesa-vdpau multilib/lib32-vulkan-mesa-layers

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
