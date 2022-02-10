#!/bin/bash

set -e

rm -f app/src/main/res/values*/strings.xml
rm -f module/src/main/res/values*/strings.xml
rm -f build/crowdin-status.txt