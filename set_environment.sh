#!/bin/sh

cat <<EOF > /usr/share/nginx/html/environment.js
// Generated at startup
window.VUE_APP_API_BASE_URL="${VUE_APP_API_BASE_URL}"
EOF