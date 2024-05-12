#!/bin/bash

function make_hash { # raw password
    echo $1 | sha256sum | awk '{print $1}'
}

function checkUserExist { # login
    usernamedb=$($sqlite3 $DB_FILE "SELECT username FROM $USERS_TABLE WHERE username = '$1';")
    if [[ $usernamedb == '' ]]
    then
        echo "Такого пользователя нет в базе данных!"
        return 1
    fi

}

function checkLoginRepeat { # login
    usernamed=$($sqlite3 $DB_FILE "SELECT username FROM $USERS_TABLE WHERE username = '$1';")
    if [[ $usernamed != '' ]]
    then
        echo "Такой пользователь уже есть базе данных!"
        return 1
    fi
}

function checkPhoneRepeat { # phone_number
    phone=$($sqlite3 $DB_FILE "SELECT phone_number FROM $USERS_TABLE WHERE phone_number = '$1';")
    if [[ $phone != '' ]]
    then
        echo "Такой пользователь уже есть базе данных!"
        return 1
    fi
}

function validatePassword { # password
    password=$($sqlite3 $DB_FILE "SELECT password FROM $USERS_TABLE WHERE password = '$1';")
    echo $password
}
