#!/bin/bash

# Genera config.py desde variables de entorno (Koyeb)
cat > config.py << PYEOF
BOT_TOKEN = "${BOT_TOKEN}"
TELEGRAM_API = ${TELEGRAM_API}
TELEGRAM_HASH = "${TELEGRAM_HASH}"
OWNER_ID = ${OWNER_ID}
GDRIVE_ID = "${GDRIVE_ID}"
IS_TEAM_DRIVE = False
YT_DLP_OPTIONS = {"cookiefile": "cookies.txt"}
SEARCH_LIMIT = 20
SEARCH_PLUGINS = [
    "https://raw.githubusercontent.com/qbittorrent/search-plugins/master/nova3/engines/piratebay.py",
    "https://raw.githubusercontent.com/qbittorrent/search-plugins/master/nova3/engines/limetorrents.py",
    "https://raw.githubusercontent.com/qbittorrent/search-plugins/master/nova3/engines/torlock.py",
    "https://raw.githubusercontent.com/qbittorrent/search-plugins/master/nova3/engines/torrentscsv.py",
    "https://raw.githubusercontent.com/qbittorrent/search-plugins/master/nova3/engines/eztv.py",
    "https://raw.githubusercontent.com/LightDestory/qBittorrent-Search-Plugins/master/src/engines/thepiratebay.py",
    "https://raw.githubusercontent.com/v1k45/1337x-qBittorrent-search-plugin/master/leetx.py",
]
PYEOF

# Cookies desde variable de entorno
if [ -n "$COOKIES" ]; then
    printf '%s\n' "$COOKIES" > cookies.txt
fi

# Arranca el bot
source mltbenv/bin/activate
exec bash start.sh
