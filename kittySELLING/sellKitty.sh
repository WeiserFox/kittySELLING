#!/bin/bash
. ./db.sh
. ./auth.sh

function sellKitty {
    read -p "Введите имя котёнка (Не более 6 символов): " name
    name_regex=$(echo "$name" | grep -E '^.{,6}$')
    if [[ $name_regex == '' ]]
        then
        echo "Неподходящий формат записи имени котёнка!"
        return 1
    fi

    read -p "Введите возраст котёнка: " age
    age_regex=$(echo "$age" | grep -E '^[0-9]{,2}$')
    if [[ $age_regex == '' ]]
        then
        echo "Неподходящий формат записи возраста котёнка!"
        return 1
    fi

    if [[ $age -gt 12 ]]
    then
        echo "Возраст котенка должен быть 12 месяцев или меньше!"
        return 1
    fi

    read -p "Введите породу котёнка: " breed
    breed_regex=$(echo "$breed" | grep -E '^.{,12}$')
    if [[ $breed_regex == '' ]]
        then
        echo "Неподходящий формат записи породы котёнка!"
        return 1
    fi

    read -p "Введите цвет котёнка: " color
    color_regex=$(echo "$color" | grep -E '^.{,12}$')
    if [[ $color_regex == '' ]]
        then
        echo "Неподходящий формат записи цвета котёнка!"
        return 1
    fi
    
    addKitty $name $age $breed $color $(getPhoneNumber $login)
    echo "Котенок $name был добавлен."
}
