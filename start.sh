#!/bin/bash
unzip -o VDMSHOP_FULL.zip
cd shop_online/public
php -S 0.0.0.0:$PORT
