#!/bin/bash

if [ "$(id -u)" != "0" ]; then
    echo "Этот скрипт должен запускаться с правами root."
    exit 1
fi

if [ -z "$1" ]; then
    echo "Использование: $0 <новый_ip_адрес>"
    exit 1
fi

CONFIG_FILE="/etc/network/interfaces"

sed -i "s/address \([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)/address $1/" $CONFIG_FILE

CURRENT_CONFIG=$(ip addr show)

echo "Текущая сетевая конфигурация:"
echo "$CURRENT_CONFIG" | sed -e 's/[[:space:]]\+/ /g' -e 's/[[:space:]]\+$//g'

echo "Сетевая конфигурация успешно изменена. Новый IP-адрес: $1"
