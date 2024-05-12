#!/bin/bash

sqlite3=`which sqlite3`
DB_FILE=app.db
SQLITE_OPTIONS=" -column  "
KITTY_TABLE=kitties
USERS_TABLE=users

function initKitties {
$sqlite3 $DB_FILE  "
        create table IF NOT EXISTS  $KITTY_TABLE (
                id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
                kitty_name TEXT,
                kitty_age INTEGER,
                kitty_breed TEXT,
                kitty_color TEXT,
                phone_number TEXT);"
}

function addKitty { # name, age, breed, color, phone_number
if [ "$#" -lt 5 ];then
        echo "Передано недостаточно аргументов в $DB_FILE, ожидалось 5"
        exit 1
else
        $sqlite3 $DB_FILE  " insert into $KITTY_TABLE (kitty_name,kitty_age,kitty_breed,kitty_color,phone_number) values  ('""$1""', '""$2""', '""$3""', '""$4""', '""$5""')"
fi
}


function printKitties {
echo "Котята в продаже:"
echo "(Возраст представлен в месяцах)"
echo "id  имя   возраст           порода     цвет        номер телефона"
$sqlite3 $SQLITE_OPTIONS $DB_FILE <<EOF
        SELECT * FROM $KITTY_TABLE;
EOF
}

function searchByFilter { #filter, value
    echo "(Возраст представлен в месяцах)"
    echo "id  имя   возраст           порода     цвет        номер телефона"
    $sqlite3 $SQLITE_OPTIONS $DB_FILE "SELECT * FROM $KITTY_TABLE WHERE $1 = '$2';"   
}


function initUsers {
$sqlite3 $DB_FILE  "
        create table IF NOT EXISTS $USERS_TABLE (
                id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
                username TEXT UNIQUE,
                password TEXT,
                phone_number TEXT UNIQUE);"
}

function addUser { # username, password, phone_number
if [ "$#" -lt 2 ];then
        echo "Передано недостаточно аргументов в $DB_FILE, ожидалось 2"
        exit 1
else
        $sqlite3 $DB_FILE  " insert into $USERS_TABLE (username,password,phone_number) values  ('""$1""', '""$2""', '""$3""')"
fi
}

function printUserKitties { #phone_number
echo "(Возраст представлен в месяцах)"
echo "id  имя   возраст           порода     цвет        номер телефона"
$sqlite3 $SQLITE_OPTIONS $DB_FILE "SELECT * FROM $KITTY_TABLE WHERE phone_number = '$1';"
}

function getPassword { # username
    password=$($sqlite3 $DB_FILE "SELECT password FROM $USERS_TABLE WHERE username = '$1';")
    echo $password
}

function getPhoneNumber { # username
    phone=$($sqlite3 $DB_FILE "SELECT phone_number FROM $USERS_TABLE WHERE username = '$1';")
    echo $phone

}
