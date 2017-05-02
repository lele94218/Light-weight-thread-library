#!/bin/bash
pushd ../../lwt-v1-sudo-rm-rf/
./install.sh
popd

make ; make cp
pushd ../transfer/ ; sh qemu.sh unit_schedtests.sh
popd