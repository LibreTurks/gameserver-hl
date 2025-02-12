#!/bin/bash
if [[ -d "/opt/steam/new-svencoop" ]]; then
    cp -R /opt/steam/new-svencoop/* /opt/steam/svends/svencoop/
fi

exec /opt/steam/svends/svends_run $@