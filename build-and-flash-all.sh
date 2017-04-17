#!/bin/bash
#
# Copyright (c) 2017, Søren Gjesse. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# Build both user 1 and user 2.
./make.sh 1
./make.sh 2

# Flash bootloader, user 1, user 2 and default initialization data.
PROJECT_DIR=../test
esptool.py --port /dev/tty.wchusbserial1410 write_flash --flash_size 32m --flash_mode dio 0x00000 $PROJECT_DIR/boot/boot_v1.6.bin 0x01000 $PROJECT_DIR/bin/upgrade/user1.4096.new.6.bin 0x101000 $PROJECT_DIR/bin/upgrade/user2.4096.new.6.bin 0x3fc000 $PROJECT_DIR/boot/esp_init_data_default.bin 0x3fe000 $PROJECT_DIR/boot/blank.bin
