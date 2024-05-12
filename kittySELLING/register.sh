#!/bin/bash
. ./functions.sh
. ./db.sh

function register {

echo "Регистрация"
read -p "Введите имя пользователя: " login
if [[ ! -n $login ]]
then 
    echo "логин не может быть пустым"
    return 1
fi

checkLoginRepeat $login

read -p "Введите ваш контактный номер телефона: " phone_number

phone_regex=$(echo "$phone_number" | grep -E '^((\+7|7|8)+([0-9]){10})$')
if [[ $phone_regex == '' ]]
then
    echo "Некорректный номер телефона!"
    return 1
fi

checkPhoneRepeat $phone_number

read -p "Введите пароль: " password
read -p "Повторите пароль: " repeat


if [[ $password == $repeat && -n $password ]]
then 
    pswd_hash=$(make_hash $password)
    addUser $login $pswd_hash $phone_number
    echo "Пользователь  $login был зарегестрирован"
else 
    echo "Пароли не совпадают!"
    return 1
fi

}
