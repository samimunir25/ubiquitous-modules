#!/bin/bash

cat > index.html <<EOF
<h1>Hello, World</h1>
<h2>hostname of this machine is '$(hostname)'</h2>
EOF

nohup busybox httpd -f -p ${server_port} &