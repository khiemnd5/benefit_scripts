#!/bin/bash

HOST_NAME=$(hostname)
HOST_IP=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
SPACE_LEFT=$(df --output=avail -h "$PWD" | sed '1d;s/[^0-9]//g')

MESSAGE_TEXT="${HOST_NAME}-${HOST_IP} dung lượng của máy chủ này còn ${SPACE_LEFT}GB. Hãy nâng cấp ngay để dịch vụ không bị downtime."

echo "${MESSAGE_TEXT}"

generate_post_data()
{
  cat <<EOF
{
  "text": "@all ${MESSAGE_TEXT}"
}
EOF
}

if [ $SPACE_LEFT -lt 5 ]; then
    curl --location --request POST 'your_link_webhook' \
    --header 'Content-Type: application/json' \
    --data "$(generate_post_data)"
else
    echo "Hệ thống đang ổn định!"
fi
