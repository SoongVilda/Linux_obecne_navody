# Instalace NVIDIA ovladačů - Manjaro, Garuda, EndeavourOS, Arch Linux a další.
Rychlý úvod, který ti ukáže, co tě čeká.
1. Příprava systému na instalaci.
2. Instalace NVIDIA ovladačů pomocí správce balíčků.
3. Konfigurace - načtení důležitých modulů.
5. Ověření, že NVIDIA GPU funguje.

## Příprava systému na instalaci
Tento krok z pravidla bývá nutný pouze na Arch Linuxu, u ostatních distribucí se nemusí dělat, ale je vhodné se ujistit.
### Kontrola, zda je možné instalovat 32-bit software.
1. Do terminálu zadej ```sudo nano /etc/pacman.conf```
2. Šipkami na klávesnici přejdi téměř na konec souboru.
3. Měl bys zde uvidět toto.
```
#[multilib]
#Include = /etc/pacman.d/mirrorlist
```
Pokud jsou na obou řádcích hashtagy ```#```, tak je odstraň, aby to vypadalo následovně. 
```
[multilib]
Include = /etc/pacman.d/mirrorlist
```
4. Ulož to klávesovou zkratku ```CTRL O```
5. Zavři nano klávesovou zkratkou ```CTRL X```
6. Spusť příkaz ```sudo pacman -Sy```
7. Hotovo!

## Instalace NVIDIA ovladačů pomocí správce balíčků.
1. Spusť následující příkaz.
```
sudo pacman -S --needed nvidia-dkms nvidia-settings nvidia-utils lib32-nvidia-utils vulkan-icd-loader lib32-vulkan-icd-loader libvdpau lib32-libvdpau libxnvctrl opencl-nvidia lib32-opencl-nvidia cuda lib32-libvdpau
```
## Konfigurace - načtení důležitých modulů.
1. Do terminálu zadej ```sudo nano /etc/mkinitcpio.conf```
2. Hned na začátku je řádek.  
```
MODULES=
```
3. Zadej do toho řádku.
```
MODULES=(nvidia)
```
4. Řádek může vypadat následovně.
```
MODULES=(modul1 modul2 modul3 nvidia)
```
5. Ulož to klávesovou zkratkou ```CTRL O```
6. Zavři nano klávesovou zkratkou ```CTRL X```
7. Do terminálu zadej ```sudo mkinitcpio -P```
8. Pokud se v termínálu neukázal žádný fail/error souvesjící s ```nvidia``` můžeš pokračovat.
9. Restartuj počítač.
10. Hotovo

<dd>Zdroje:</dd>
<dd>https://github.com/lutris/docs/blob/master/InstallingDrivers.md</dd>
