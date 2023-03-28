#!/bin/bash

check_cgroup_tools() {
    # Проверяем, установлены ли cgroup-tools
    if ! command -v cgcreate &> /dev/null; then
        echo "cgroup-tools не установлены. Устанавливаем..."
        sudo apt-get install cgroup-tools
        # создаем контрольную группу cpu с именем mygroup
        sudo cgcreate -g cpu:mygroup
        # устанавливаем ограничение на использование ЦПУ в количестве 50 миллисекунд в секунду
        sudo cgset -r cpu.cfs_quota_us=70000 mygroup
    else
        echo "cgroup-tools установлены. Ok"
    fi
}

# Вызываем функцию для проверки установки cgroup-tools
check_cgroup_tools

# добавляем текущие процессы в контрольную группу mygroup
sudo cgclassify -g cpu:mygroup $(pgrep -u $(whoami))  &> /dev/null

