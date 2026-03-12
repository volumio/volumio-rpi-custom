#!/bin/bash

CPU=4
KERNEL_VERSION="6.12.74"

case $KERNEL_VERSION in
    "6.12.74")
      KERNEL_COMMIT="7a35bddc777d8992bdfe42f8e3d043582df2f5f8"
      PATCH="custom-6.12.zy.patch"
      ;;
    "6.12.50")
      KERNEL_COMMIT="a22bb2f110bc8953523714ac58251f47ae4e2d2b"
      PATCH="custom-6.12.zx.patch"
      ;;
    "6.12.47")
      KERNEL_COMMIT="6d1da66a7b1358c9cd324286239f37203b7ce25c"
      PATCH="custom-6.12.z.patch"
      ;;
    "6.12.34")
      KERNEL_COMMIT="4f435f9e89a133baab3e2c9624b460af335bbe91"
      PATCH="custom-6.12.y.patch"
      ;;
    "6.12.27")
      KERNEL_COMMIT="f54e67fef6e726725d3a8f56d232194497bd247c"
      PATCH="custom-6.12.x.patch"
      ;;
    "6.6.62")
      KERNEL_COMMIT="9a9bda382acec723c901e5ae7c7f415d9afbf635"
      PATCH="custom-6.6.y.patch"
      ;;
    "6.6.56")
      KERNEL_COMMIT="a5efb544aeb14338b481c3bdc27f709e8ee3cf8c"
      PATCH="custom-6.6.y.patch"
      ;;
    "6.6.51")
      KERNEL_COMMIT="d5a7dbe77b71974b9abb133a4b5210a8070c9284"
      PATCH="custom-6.6.x.patch"
      ;;
    "6.6.47")
      KERNEL_COMMIT="a0d314ac077cda7cbacee1850e84a57af9919f94"
      PATCH="custom-6.6.x.patch"
      ;;
    "6.1.77")
      KERNEL_COMMIT="5fc4f643d2e9c5aa972828705a902d184527ae3f"
      PATCH="custom-6.1.y.patch"
      ;;
    "6.1.70")
      KERNEL_COMMIT="fc9319fda550a86dc6c23c12adda54a0f8163f22"
      PATCH="custom-6.1.x.patch"
      ;;
    "6.1.69")
      KERNEL_COMMIT="ec8e8136d773de83e313aaf983e664079cce2815"
      PATCH="custom-6.1.x.patch"
      ;;
    "6.1.64")
      KERNEL_COMMIT="01145f0eb166cbc68dd2fe63740fac04d682133e"
      PATCH="custom-6.1.x.patch"
      ;;
    "6.1.58")
      KERNEL_COMMIT="7b859959a6642aff44acdfd957d6d66f6756021e"
      PATCH="custom-6.1.x.patch"
      ;;
    "6.1.57")
      KERNEL_COMMIT="12833d1bee03c4ac58dc4addf411944a189f1dfd"
      PATCH="custom-6.1.x.patch"
      ;;
esac

echo "!!!  Build modules for kernel ${KERNEL_VERSION}  !!!"

echo "!!!  Build RPi0 kernel and modules  !!!"
cd linux-${KERNEL_VERSION}+/
KERNEL=kernel
make -j${CPU} ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcmrpi_defconfig
make -j${CPU} ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs
cd ..
echo "!!!  RPi0 build done  !!!"
echo "-------------------------"

echo "!!!  Build RPi2 kernel and modules  !!!"
cd linux-${KERNEL_VERSION}-v7+/
KERNEL=kernel7
make -j${CPU} ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig
make -j${CPU} ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs
cd ..
echo "!!!  RPi2 build done  !!!"
echo "-------------------------"

echo "!!!  Build RPi3/4 32-bit kernel and modules  !!!"
cd linux-${KERNEL_VERSION}-v7l+/
KERNEL=kernel7l
make -j${CPU} ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2711_defconfig
make -j${CPU} ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs
cd ..
echo "!!!  RPi3/4 build 32-bit done  !!!"
echo "-------------------------"

echo "!!!  Build RPi3/4/5 64-bit kernel and modules  !!!"
cd linux-${KERNEL_VERSION}-v8+/
KERNEL=kernel8
make -j${CPU} ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2711_defconfig
make -j${CPU} ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image modules dtbs
cd ..
echo "!!!  RPi3/4/5 64-bit build done  !!!"
echo "-------------------------"

echo "!!!  Compressing modules with XZ  !!!"

xz -f linux-${KERNEL_VERSION}+/drivers/gpu/drm/panel/panel-waveshare-dsi.ko
xz -f linux-${KERNEL_VERSION}-v7+/drivers/gpu/drm/panel/panel-waveshare-dsi.ko
xz -f linux-${KERNEL_VERSION}-v7l+/drivers/gpu/drm/panel/panel-waveshare-dsi.ko
xz -f  linux-${KERNEL_VERSION}-v8+/drivers/gpu/drm/panel/panel-waveshare-dsi.ko

xz -f linux-${KERNEL_VERSION}+/drivers/gpu/drm/panel/panel-waveshare-dsi-v2.ko
xz -f linux-${KERNEL_VERSION}-v7+/drivers/gpu/drm/panel/panel-waveshare-dsi-v2.ko
xz -f linux-${KERNEL_VERSION}-v7l+/drivers/gpu/drm/panel/panel-waveshare-dsi-v2.ko
xz -f  linux-${KERNEL_VERSION}-v8+/drivers/gpu/drm/panel/panel-waveshare-dsi-v2.ko

xz -f linux-${KERNEL_VERSION}+/drivers/net/usb/ax88179_178a.ko
xz -f linux-${KERNEL_VERSION}-v7+/drivers/net/usb/ax88179_178a.ko
xz -f linux-${KERNEL_VERSION}-v7l+/drivers/net/usb/ax88179_178a.ko
xz -f  linux-${KERNEL_VERSION}-v8+/drivers/net/usb/ax88179_178a.ko

xz -f linux-${KERNEL_VERSION}+/sound/soc/bcm/snd-soc-allo-piano-dac-plus.ko
xz -f linux-${KERNEL_VERSION}-v7+/sound/soc/bcm/snd-soc-allo-piano-dac-plus.ko
xz -f linux-${KERNEL_VERSION}-v7l+/sound/soc/bcm/snd-soc-allo-piano-dac-plus.ko
xz -f  linux-${KERNEL_VERSION}-v8+/sound/soc/bcm/snd-soc-allo-piano-dac-plus.ko

xz -f linux-${KERNEL_VERSION}+/sound/soc/codecs/snd-soc-pcm512x.ko
xz -f linux-${KERNEL_VERSION}-v7+/sound/soc/codecs/snd-soc-pcm512x.ko
xz -f linux-${KERNEL_VERSION}-v7l+/sound/soc/codecs/snd-soc-pcm512x.ko
xz -f  linux-${KERNEL_VERSION}-v8+/sound/soc/codecs/snd-soc-pcm512x.ko

xz -f linux-${KERNEL_VERSION}+/sound/usb/snd-usb-audio.ko
xz -f linux-${KERNEL_VERSION}-v7+/sound/usb/snd-usb-audio.ko
xz -f linux-${KERNEL_VERSION}-v7l+/sound/usb/snd-usb-audio.ko
xz -f linux-${KERNEL_VERSION}-v8+/sound/usb/snd-usb-audio.ko

find linux-${KERNEL_VERSION}+/drivers/net/wireless/realtek/rtw88/ -name '*.ko' -exec xz -f {} \;
find linux-${KERNEL_VERSION}-v7+/drivers/net/wireless/realtek/rtw88/ -name '*.ko' -exec xz -f {} \;
find linux-${KERNEL_VERSION}-v7l+/drivers/net/wireless/realtek/rtw88/ -name '*.ko' -exec xz -f {} \;
find linux-${KERNEL_VERSION}-v8+/drivers/net/wireless/realtek/rtw88/ -name '*.ko' -exec xz -f {} \;

echo "!!!  Creating archive  !!!"
rm -rf modules-rpi-${KERNEL_VERSION}-custom/

mkdir -p modules-rpi-${KERNEL_VERSION}-custom/boot/overlays
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}+/kernel/drivers/gpu/drm/panel/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7+/kernel/drivers/gpu/drm/panel/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7l+/kernel/drivers/gpu/drm/panel/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v8+/kernel/drivers/gpu/drm/panel/

mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}+/kernel/drivers/net/usb/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7+/kernel/drivers/net/usb/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7l+/kernel/drivers/net/usb/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v8+/kernel/drivers/net/usb/

mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}+/kernel/sound/soc/bcm/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7+/kernel/sound/soc/bcm/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7l+/kernel/sound/soc/bcm/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v8+/kernel/sound/soc/bcm/

mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}+/kernel/sound/soc/codecs/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7+/kernel/sound/soc/codecs/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7l+/kernel/sound/soc/codecs/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v8+/kernel/sound/soc/codecs/

mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}+/kernel/sound/usb/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7+/kernel/sound/usb/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7l+/kernel/sound/usb/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v8+/kernel/sound/usb/

mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}+/kernel/drivers/net/wireless/realtek/rtw88/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7+/kernel/drivers/net/wireless/realtek/rtw88/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7l+/kernel/drivers/net/wireless/realtek/rtw88/
mkdir -p modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v8+/kernel/drivers/net/wireless/realtek/rtw88/

cp linux-${KERNEL_VERSION}+/arch/arm/boot/dts/overlays/vc4-kms-dsi-waveshare-panel.dtbo modules-rpi-${KERNEL_VERSION}-custom/boot/overlays
cp linux-${KERNEL_VERSION}+/arch/arm/boot/dts/overlays/vc4-kms-dsi-ili9881-7inch.dtbo modules-rpi-${KERNEL_VERSION}-custom/boot/overlays
cp linux-${KERNEL_VERSION}+/arch/arm/boot/dts/overlays/es9039q2m-i2s.dtbo modules-rpi-${KERNEL_VERSION}-custom/boot/overlays

cp linux-${KERNEL_VERSION}+/drivers/gpu/drm/panel/panel-waveshare-dsi.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}+/kernel/drivers/gpu/drm/panel/
cp linux-${KERNEL_VERSION}-v7+/drivers/gpu/drm/panel/panel-waveshare-dsi.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7+/kernel/drivers/gpu/drm/panel/
cp linux-${KERNEL_VERSION}-v7l+/drivers/gpu/drm/panel/panel-waveshare-dsi.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7l+/kernel/drivers/gpu/drm/panel/
cp linux-${KERNEL_VERSION}-v8+/drivers/gpu/drm/panel/panel-waveshare-dsi.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v8+/kernel/drivers/gpu/drm/panel/

cp linux-${KERNEL_VERSION}+/drivers/gpu/drm/panel/panel-waveshare-dsi-v2.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}+/kernel/drivers/gpu/drm/panel/
cp linux-${KERNEL_VERSION}-v7+/drivers/gpu/drm/panel/panel-waveshare-dsi-v2.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7+/kernel/drivers/gpu/drm/panel/
cp linux-${KERNEL_VERSION}-v7l+/drivers/gpu/drm/panel/panel-waveshare-dsi-v2.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7l+/kernel/drivers/gpu/drm/panel/
cp linux-${KERNEL_VERSION}-v8+/drivers/gpu/drm/panel/panel-waveshare-dsi-v2.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v8+/kernel/drivers/gpu/drm/panel/

cp linux-${KERNEL_VERSION}+/drivers/net/usb/ax88179_178a.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}+/kernel/drivers/net/usb/
cp linux-${KERNEL_VERSION}-v7+/drivers/net/usb/ax88179_178a.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7+/kernel/drivers/net/usb/
cp linux-${KERNEL_VERSION}-v7l+/drivers/net/usb/ax88179_178a.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7l+/kernel/drivers/net/usb/
cp linux-${KERNEL_VERSION}-v8+/drivers/net/usb/ax88179_178a.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v8+/kernel/drivers/net/usb/

cp linux-${KERNEL_VERSION}+/sound/soc/bcm/snd-soc-allo-piano-dac-plus.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}+/kernel/sound/soc/bcm/
cp linux-${KERNEL_VERSION}-v7+/sound/soc/bcm/snd-soc-allo-piano-dac-plus.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7+/kernel/sound/soc/bcm/
cp linux-${KERNEL_VERSION}-v7l+/sound/soc/bcm/snd-soc-allo-piano-dac-plus.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7l+/kernel/sound/soc/bcm/
cp linux-${KERNEL_VERSION}-v8+/sound/soc/bcm/snd-soc-allo-piano-dac-plus.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v8+/kernel/sound/soc/bcm/

cp linux-${KERNEL_VERSION}+/sound/soc/codecs/snd-soc-pcm512x.ko* modules-rpi-${KERNEL_VERSION}-custom//lib/modules/${KERNEL_VERSION}+/kernel/sound/soc/codecs/
cp linux-${KERNEL_VERSION}-v7+/sound/soc/codecs/snd-soc-pcm512x.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7+/kernel/sound/soc/codecs/
cp linux-${KERNEL_VERSION}-v7l+/sound/soc/codecs/snd-soc-pcm512x.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7l+/kernel/sound/soc/codecs/
cp linux-${KERNEL_VERSION}-v8+/sound/soc/codecs/snd-soc-pcm512x.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v8+/kernel/sound/soc/codecs/

cp linux-${KERNEL_VERSION}+/sound/usb/snd-usb-audio.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}+/kernel/sound/usb/
cp linux-${KERNEL_VERSION}-v7+/sound/usb/snd-usb-audio.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7+/kernel/sound/usb/
cp linux-${KERNEL_VERSION}-v7l+/sound/usb/snd-usb-audio.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7l+/kernel/sound/usb/
cp linux-${KERNEL_VERSION}-v8+/sound/usb/snd-usb-audio.ko* modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v8+/kernel/sound/usb/

find linux-${KERNEL_VERSION}+/drivers/net/wireless/realtek/rtw88/ -name '*.ko.xz' -exec cp {} modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}+/kernel/drivers/net/wireless/realtek/rtw88/ \;
find linux-${KERNEL_VERSION}-v7+/drivers/net/wireless/realtek/rtw88/ -name '*.ko.xz' -exec cp {} modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7+/kernel/drivers/net/wireless/realtek/rtw88/ \;
find linux-${KERNEL_VERSION}-v7l+/drivers/net/wireless/realtek/rtw88/ -name '*.ko.xz' -exec cp {} modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v7l+/kernel/drivers/net/wireless/realtek/rtw88/ \;
find linux-${KERNEL_VERSION}-v8+/drivers/net/wireless/realtek/rtw88/ -name '*.ko.xz' -exec cp {} modules-rpi-${KERNEL_VERSION}-custom/lib/modules/${KERNEL_VERSION}-v8+/kernel/drivers/net/wireless/realtek/rtw88/ \;

tar -czvf modules-rpi-${KERNEL_VERSION}-custom.tar.gz modules-rpi-${KERNEL_VERSION}-custom/ --owner=0 --group=0
md5sum modules-rpi-${KERNEL_VERSION}-custom.tar.gz > modules-rpi-${KERNEL_VERSION}-custom.md5sum.txt
sha1sum modules-rpi-${KERNEL_VERSION}-custom.tar.gz > modules-rpi-${KERNEL_VERSION}-custom.sha1sum.txt
rm -rf modules-rpi-${KERNEL_VERSION}-custom/
mkdir -p ../output
mv modules-rpi-${KERNEL_VERSION}-custom* ../output/

echo "!!!  Done  !!!"
