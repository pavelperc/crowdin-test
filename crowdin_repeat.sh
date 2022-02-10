#!/bin/bash

for i in 1 2 3 4 5;
do
  bash "$1" && break
  sleep $i
done
