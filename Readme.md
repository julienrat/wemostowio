Wemos to Wio node
=

----
##Principe
Ce tutoriel permet de convertir une carte Wemos en une carte compatible Wio Node. Et ainsi construire facilement des objets connectés.

###C'est quoi un Wio Node ?
Le Wio Node est une carte développée par Seeedstudio, basée sur un ESP8266 permettant de construire des petits appareils connectés à divers services tels que twitter, facebook, etc ...
La configuration du Wio Node se fait par un téléphone sous Android et via une application dédiée.

Pour plus d'informations, vous pouvez regarder la vidéo de présentation :
[![IMAGE](/images/video.png)](https://www.youtube.com/watch?v=N-13m8Lvzxs)


##Flasher le Wemos
### Récupérez le firmware Wio Node
[user1.bin](https://github.com/Seeed-Studio/Wio_Link/raw/master/users_build/local_user_00000000000000000000/user1.bin)

[user2.bin](https://github.com/Seeed-Studio/Wio_Link/raw/master/users_build/local_user_00000000000000000000/user2.bin)

[bootloader](http://www.seeedstudio.com/wiki/images/4/4b/Esp8266sdk1.4.1.zip)

Décompressez Bootloader et copiez user1.bin, user2.bin, boot_v1.4(b1).bin, blank.bin et esp_init_data_default.bin dans le même repertoire
### Installez esptool 
Suivant votre distribution, vous pouvez trouver esptool dans vos dépots, ou le télécharger à cette adresse https://github.com/themadinventor/esptool

### Flashez 

```shell
esptool.py -p /dev/tty.SLAB_USBtoUART -b 230400 write_flash --flash_size 32m-c1 0x0000 boot_v1.4(b1).bin 0x1000 user1.bin 0x101000 user2.bin 0x3fc000 esp_init_data_default.bin 0x3fe000 blank.bin
```

## Installer l'application Android

##


###Schema de cablage
Fritzing | Eagle
---------|---------
![selection](/images/votbox_bb.png) | ![selection](/images/schema.png) 

###Vue PCB
Top | Bottom 
---------|---------
![selection](/3D/wio_shield_top.png) | ![selection](/3D/wio_shield.png) 
