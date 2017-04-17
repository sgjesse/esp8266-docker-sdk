#!/bin/bash
#
# Copyright (c) 2017, Søren Gjesse. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# Build user 1.
./make.sh

# Flash user 1.
PROJECT_DIR=../test
esptool.py --port /dev/tty.wchusbserial1410 write_flash --flash_size 32m --flash_mode dio 0x01000 $PROJECT_DIR/bin/upgrade/user1.4096.new.6.bin
