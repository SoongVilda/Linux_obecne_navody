# Návod pro NVIDIA notebooky s distribucí založenou na Arch Linuxu
Návod slouží k řešení častých problémů notebooků s NVIDIA kartou na GNU/Linux. Vhodné pro Manjaro, EndeavourOS, Garuda, Arch Linux a další.
## Úvod - základní funkčnost NVIDIA GPU
Rychlý úvod, který ti ukáže, co tě čeká.
1. Příprava systému na instalaci.
2. Instalace NVIDIA ovladačů pomocí správce balíčků.
3. Konfigurace 1 - načtení důležitých modulů.
4. Konfigurace 2 - přepinání karet (iGPU a dGPU)
5. Ověření, že NVIDIA GPU funguje.
6. Práce s přepínáním karet.

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
sudo pacman -S --needed nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
```
## Konfigurace 1 - načtení důležitých modulů.
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

## Konfigurace 2 - přepinání karet (iGPU a dGPU).
Teď nastavíme přepínání mezi Integrovaným GPU a diskrétním GPU, ať tu NVIDIA kartu můžeme využívat.
1. Do terminálu zadej ```sudo pacman -S nvidia-prime```
2. Restartuj notebook.

## Ověření, že NVIDIA GPU funguje.
Nainstalujueme k tomu nástroj, co nám to pomůže zjistí.
1. Do terminálu zadej ```sudo pacman -S mesa-demos lib32-mesa-demos```
2. Do terminálu zadej ```glxinfo | grep "OpenGL renderer"``` u mě výstup v terminálu vypadá následovně.
```
[vilda@arch-dell ~]$ glxinfo | grep "OpenGL renderer"
OpenGL renderer string: Mesa Intel(R) Xe Graphics (TGL GT2)
```
3. Nyní přidáme příkaz. 
```
prime-run
```
4. Takže celý příkaz bude vypadat takto. 
```
prime-run glxinfo | grep "OpenGL renderer"
```
5. Pokud se ti ukázala NVIDIA karta, gratluji, vše funguje!
## Práce s přepínáním karet.
Vždy, když budeš potřebovat něco spustit s NVIDIA GPU, stačí zadat.
```
prime-run program
```
Příklad 1: Spuštění hry Xonotic s NVIDIA GPU. 
```
prime-run xonotic-sdl
```
Příklad 2: Spuštění programu na úpravu fotek darktable s NVIDIA GPU.
```
prime-run darktable
```
### Steam
Pokud chceš zapnout hru ve Steamu s NVIDIA GPU, stačí zadat následující příkaz.
```
prime-run %command%
```
To je vše k základní funkčnosti NVIDIA GPU.
