#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "etc" ls /etc/postgresql | grep 17
check "client" psql --version | grep 17
check "data" sudo cat /var/lib/postgresql/data/PG_VERSION | grep 17

# PostGIS specific tests
check "postgis-extension" sudo -u postgres psql -c "CREATE EXTENSION IF NOT EXISTS postgis;" -c "SELECT PostGIS_version();"
check "postgis-topology" sudo -u postgres psql -c "CREATE EXTENSION IF NOT EXISTS postgis_topology;"
check "postgis-raster" sudo -u postgres psql -c "CREATE EXTENSION IF NOT EXISTS postgis_raster;"

# Report result
reportResults