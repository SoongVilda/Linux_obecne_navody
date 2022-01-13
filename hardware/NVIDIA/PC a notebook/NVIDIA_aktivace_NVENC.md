# Aktivace NVENC, pro hardwarovou akceleraci videa.
Zde je postup, jak můžeš zprovoznit NVENC na Linuxu, protože po pouhé instalaci NVIDIA ovladačů není aktivní.

1. Zadej do terminálu příkaz.
```
sudo nano /etc/udev/rules.d/70-nvidia.rules
```
3. Zkopíruj následující text.
```
ACTION=="add", DEVPATH=="/bus/pci/drivers/nvidia", RUN+="/usr/bin/nvidia-modprobe -c0 -u"
```
4. Vlož zkopírovány text.
5. Ulož to klávesovou zkratkou ```CTRL O```
6. Zavři nano klávesovou zkratkou ```CTRL X```

## Udržení modulu nvidia_uvm.
1. Do terminálu zadej ```sudo nano /etc/mkinitcpio.conf```
2. Hned na začátku je řádek.  
```
MODULES=
```
3. Zadej do toho řádku.
```
MODULES=(nvidia_uvm)
```
4. Řádek může vypadat následovně.
```
MODULES=(modul1 modul2 modul3 nvidia nvidia_uvm)
```
5. Ulož to klávesovou zkratkou ```CTRL O```
6. Zavři nano klávesovou zkratkou ```CTRL X```
7. Do terminálu zadej ```sudo mkinitcpio -P```
8. Pokud se v termínálu neukázal žádný fail/error souvesjící s ```nvidia``` nebo ```nvidia_uvm``` můžeš pokračovat.
## Načtení nových udev pravidel
1. Do terminálu zadej.
```
sudo udevadm control --reload
```
2. Do terminálu zadej.
```
sudo udevadm trigger
```
3. Hotovo.
