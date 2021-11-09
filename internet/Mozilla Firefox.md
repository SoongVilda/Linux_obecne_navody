
# Vylepšení výkonu skrz Webrender a hardwarovou akcelerovi přes GPU.
Inspirováno Arch Wiki a tipy ode mě. S tímto nastavením je např. Facebook naprosto plynulý a to i na FullHD 75Hz monitoru.
- Testováno na NVIDIA GeForce GTX960. (Kompletně funkční!)
- Testováno na Intel Xe (Citlivá nastavení s variantou 1)

Potřebuješ Firefox 94 a novější. Napiš do URL řádku ```about:config```. Následně nastav všechny hodnoty, jako je zmíněno níže.

### Citlivá nastavení, pokud ti panely Firefoxu padají, hodnoty vrať do počátečního stavu.
```
media.ffvpx.enabled=false
media.rdd-vpx.enabled=false
media.ffmpeg.vaapi.enabled=true
media.navigator.mediadatadecoder_vpx_enabled=true
```
### Oprava citlivých nastavení varianta 1
```
media.ffvpx.enabled=true
media.rdd-vpx.enabled=true
media.ffmpeg.vaapi.enabled=false
media.navigator.mediadatadecoder_vpx_enabled=true
```

### Méně citlivá nastavení, měly by fungovat stabilně.
```
gfx.webrender.all=true
gfx.webrender.compositor=true
gfx.webrender.compositor.force-enabled=true
gfx.webrender.precache-shaders=true
gfx.webrender.use-optimized-shaders=true
gfx.webrender.program-binary-disk=true
media.hardware-video-decoding.enabled=true
media.hardware-video-decoding.force-enabled=true
media.gpu-process-decoder=true
dom.webgpu.enabled=true
browser.cache.disk.enable=false
```
<dd>Zdroje:</dd>
<dd>https://wiki.archlinux.org/title/firefox</dd>
<dd>https://wiki.archlinux.org/title/Firefox/Tweaks</dd>

### Pro uživatele Waylandu
Osobně už trvale používám Wayland na KDE Plasma (Ultrabook s Intel Xe)
1. Otevři terminál a spusť příkaz ```MOZ_ENABLE_WAYLAND=1 firefox```
2. Pokud Firefox běží v pohodě a zdá se ti, že plynuleji (Já to testuji na plynulosti Facebook - nejvíce náročný a zasekaný web, co znám), jako mně s Intel Xe, tak gratuluji!
3. Jdi na ```about:support``` a zkontroluj, jestli najdeš ```MOZ_ENABLE_WAYLAND``` s hodnotou ```1```
<dd> Nyní máš jistotu, že ti Firefox pracuje s Waylandem. Ať Firefox nemusíš vždy zapínat přes terminál pokračuj níže. </dd>

1. ```sudo nano /etc/environment```
2. Přidej hodnotu ```MOZ_ENABLE_WAYLAND=1``` a ulož to.
3. Restartuj počítač.
4. Firefox otevři přes ikonu. 
5. Zkontroluj ```about:support``` a že je zde ```MOZ_ENABLE_WAYLAND``` s hodnotou ```1```
6. Hotovo, máš Firefox fungující na Waylandu s hardwarovou akcelerací.

<dd>Zdroje:</dd>
<dd>https://wiki.archlinux.org/title/firefox#Wayland</dd>
