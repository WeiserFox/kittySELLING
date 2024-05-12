#!/bin/bash
. ./functions.sh
. ./db.sh

function auth {

echo "Авторизация"
read -p "Введите логин: " login
checkUserExist $login
if [[ $? -eq 1 ]]
then 
    echo "Пользователь $login не найден"
    exit 1
fi

attempts=3
while [[ $attempts -gt 0 ]]
do 
    read -s -p "Введите пароль: " password
    hash_pswd=$(make_hash $password)
    userpswd=$(getPassword $login)
    if [[ $hash_pswd == $userpswd ]]
    then
        echo $login
        echo "Вы авторизовались!"
        break
    else 
        attempts=$(($attempts-1))
        echo " Пароль введён неверно, осталось $attempts попыток"
    fi
done

if [[ attempts -eq 0 ]]
then
    echo "Слишком много попыток!"
    exit 1
fi
}
