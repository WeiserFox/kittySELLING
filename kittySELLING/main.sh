#!/bin/bash
. ./auth.sh
. ./register.sh
. ./db.sh
. ./searchFilter.sh
. ./sellKitty.sh

initKitties
initUsers


function auth_menu {
    clear
    echo "Добро пожаловать в скрипт ПРОДАЖА котят"

    echo "Выберите действие:"
    read -p "Регистрация (1), Авторизация (2) -> " choice

    if [[ choice -eq 1 ]]
    then
        clear
        register
        sleep 2
        auth_menu
    elif [[ choice -eq 2 ]]
    then
        clear
        auth
        clear
        main
    fi
}

function main {
    echo "Добро пожаловать, $login"
    echo "Выберите действие:"

    read -p "Посмотреть котят в ПРОДАЖЕ (1)
ПРОДАТЬ котят (2)
МОИ котята (3)
Искать по фильтру (4) -> " choice2

    if [[ choice2 -eq 1 ]]
    then
        clear
        printKitties
        echo
        main
    elif [[ choice2 -eq 2 ]]
    then
        clear
        sellKitty
        sleep 2
        clear
        main
    elif [[ choice2 -eq 3 ]]
    then
        clear
        printUserKitties $(getPhoneNumber $login)
        echo
        main
    elif [[ choice2 -eq 4 ]]
    then
        clear
        search
        echo
        main
    else
        clear
        echo "Нет такого варианта"
        sleep 2
        main
    fi
    
}

auth_menu
