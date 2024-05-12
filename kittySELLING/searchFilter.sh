#!/bin/bash
. ./db.sh


function search {
    echo "По какому фильтру вы хотите осуществить поиск?"
    read -p "id (1)
имя (2)
возраст (3)
порода (4)
цвет (5)
номер телефона (6) -> " filter
    read -p "Введите значение фильтра -> " value
    case $filter in

  1)
    searchByFilter id $value
    ;;

  2)
    searchByFilter kitty_name $value
    ;;

  3)
    searchByFilter kitty_age $value
    ;;

  4)
    searchByFilter kitty_breed $value
    ;;

  5)
    searchByFilter kitty_color $value
    ;;

  6)
    searchByFilter phone_number $value
    ;;

  *)
    echo "Нет такого варианта!"
    ;;
esac
}
