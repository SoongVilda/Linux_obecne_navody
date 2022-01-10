## Přepinání karet (iGPU a dGPU), bez jakéhokoliv dotatečného software. Funkční na všech GNU/Linux distribucích.
Vyzkoušíme přepínání mezi Integrovaným GPU a diskrétním GPU, ať NVIDIA kartu můžeme využívat.

## Ověření, že NVIDIA GPU funguje.
Nainstalujueme k tomu nástroj, co nám to pomůže zjistí. Pokud nemáš čistý Arch Linux, můžeš instalací zmínených balíků přeskočit, pravděpodobně je už máš nainstalované.
1. Do terminálu zadej ```sudo pacman -S mesa-demos lib32-mesa-demos```
2. Do terminálu zadej ```glxinfo | grep "OpenGL renderer"``` u mě výstup v terminálu vypadá následovně.
```
[vilda@arch-dell ~]$ glxinfo | grep "OpenGL renderer"
OpenGL renderer string: Mesa Intel(R) Xe Graphics (TGL GT2)
```
3. Nyní použijeme příkaz, který incializacuje NVIDIA GPU přes PRIME Render Offload.
```
__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia
```
4. Celý příkaz bude vypadat takto. 
```
__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia glxinfo | grep "OpenGL renderer"
```
5. Pokud se ti ukázala NVIDIA karta, gratluji, vše funguje!
## Práce s přepínáním karet.
Vždy, když budeš potřebovat něco spustit s NVIDIA GPU, stačí zadat níže zmíněný příkaz. Pamatuj, za ```program``` stačí zadat jakýkoliv balík.

```
__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia program
```
Příklad 1: Spuštění hry Xonotic s NVIDIA GPU. 
```
__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia xonotic-sdl
```
Příklad 2: Spuštění programu na úpravu fotek darktable s NVIDIA GPU.
```
__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia darktable
```
### Steam
Pokud chceš zapnout hru ve Steamu s NVIDIA GPU, stačí zadat následující příkaz.
```
__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia %command%
```
To je vše k základní funkčnosti NVIDIA GPU.
