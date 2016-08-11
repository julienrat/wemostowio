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
### Récupérer le firmware Wio Node
[user1.bin](https://github.com/Seeed-Studio/Wio_Link/raw/master/users_build/local_user_00000000000000000000/user1.bin)

[user2.bin](https://github.com/Seeed-Studio/Wio_Link/raw/master/users_build/local_user_00000000000000000000/user2.bin)

[bootloader](http://www.seeedstudio.com/wiki/images/4/4b/Esp8266sdk1.4.1.zip)

Décompresser Bootloader et copier user1.bin, user2.bin, boot_v1.4(b1).bin, blank.bin et esp_init_data_default.bin dans le même repertoire
### Installer esptool 
Suivant votre distribution, vous pouvez trouver esptool dans vos dépots, ou le télécharger à cette adresse https://github.com/themadinventor/esptool

### Flasher le Wemos

```shell
esptool -p /dev/ttyUSB0 -b 230400 write_flash --flash_size 32m-c1 0x0000 boot_v1.4\(b1\).bin 0x1000 user1.bin 0x101000 user2.bin 0x3fc000 esp_init_data_default.bin 0x3fe000 blank.bin

```

## Installer l'application Android
https://play.google.com/store/apps/details?id=cc.seeed.iot.ap

## Utilisation // Configuration
###Configuration
- Appuyer sur le bouton fonction 4 secondes afin de mettre le wemos en mode "Configuration". La led arrete de clignoter et effectue un "fading".
- Démarrer l'application Wio sur le téléphone.


Description | Screenshot
---------|---------
Connectez vous ou créez un compte | ![login](/images/login.png) 
Ajoutez votre Wemos, et choisissez Wio Node | ![add_device](/images/add_device.png) 
Assurez-vous que la led bleue effectue un "fading", sinon appuyez 4 sec sur le bouton Fonction | ![App](/images/next.png)
Connectez vous au wemos, il devrait apparaitre dans la liste | ![selection local network](/images/reseau_device.png)
Choisissez un nom pour votre Wemos | ![name](/images/device_name.png)
Choisissez le capteur que vous souhaitez connecter au wemos | ![sensor](/images/sensor_choose.png)
A l'aide d'un drag'n'drop glissez le capteur sur un connecteur de votre choix | ![sensor2](/images/sensor_choose2.png)
Cliquez sur "Update Firmware" pour envoyer la nouvelle configuration au wemos | ![upload](/images/upload.png)

Voila, votre wemos est opérationel, il ne reste plus qu'à le connecter à un canal de diffusion, ici c'est le canal de diffusion IFTTT que nous alons choisir.

###Utilisation simple
Pour l'instant Un seul canal est disponible pour wio : IFTTT 

Ce service, apres inscription permet de relier nos capteurs à une multitude de services tels que Twitter, Facebook et même les lamps connectées de chez philips .. etc.

Le principe est simple IF This Then That.(Si Ceci Alors Cela) et se présente sou la forme de recettes : Le site [IFTTT](https://ifttt.com)

Par exemple :
Un tweet quand il fait chaud :
![selection](/images/recette.png)

On peux aussi connecter IFTTT à la platteforme IO d'adafruit

[Recette IFTTT](https://ifttt.com/recipes/452996-temperature-data-viz)| [DashBoard Adafruit](https://io.adafruit.com/ratjulien/welcome-dashboard)
---------|---------
![selection](/images/recette_ada.png) | ![selection](/images/recette_adafruit.png) 

###Schéma de câblage
[Fritzing](/schema/wemos_wio_sch.fzz)| Eagle
---------|---------
![selection](/images/WioNode_sch_fritzing.png) | ![selection](/images/WioNode_sch.png) 


###Vue PCB
Top | Bottom 
---------|---------
![selection](/3D/wio_shield_top.png) | ![selection](/3D/wio_shield.png) 

###Production
Typon | [Plaque d'essais](/schema/wemos_wio_plaque_essais.fzz)
---------|---------
![selection](/images/PCB.png) | ![selection](/images/WioNode_plaque_essais.png) 
