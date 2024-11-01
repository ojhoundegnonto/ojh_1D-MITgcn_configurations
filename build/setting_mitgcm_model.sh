#!/bin/bash

../../../../../MITgcm/tools/genmake2 -mods ../code
make depend
make
cp mitgcmuv ../run/
