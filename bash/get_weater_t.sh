#!/usr/bin/env bash



function get_weather_from_yandex_for () {
    local yandex_url="$1"
    local tmp=/tmp/curl-from-yandex-$(date '+%Y.%m.%d-%H:%M:%S:%s').html
    local data=$tmp.sed

    curl --max-time 10 "$yandex_url" > $tmp 2>>/dev/null
    sed -e "s/<div /\n<div /g" $tmp > $data

    local title=$(cat $data | grep header-title | grep main_title | sed 's/.*">//g' | tr -d "\"\/<>[a-z]")
    local weather=$(cat $data | grep fact__temp-wrap | awk -F 'aria-label=' '{print $2}' | cut -d'"' -f2)
    local wind=$( cat $data | grep term__value | grep wind-speed | sed 's/.*a11y-hidden//g' | tr -d "\"\/<>[a-z]")
    local humid=$(cat $data | grep term__value | grep humidity   | sed 's/.*a11y-hidden//g' | tr -d "\"\/<>[a-z]")
    local press=$(cat $data | grep term__value | grep pressure   | sed 's/.*a11y-hidden//g' | tr -d "\"\/<>[a-z]")

    echo $title
    echo $weather
    echo $wind
    echo $humid
    echo $press
}



function get_weather_from_yandex_for_Obninsk () {
    local url="http://tower.obninskiy.net/"
    local tmp=/tmp/curl-from-obninsk-tower-$(date '+%Y.%m.%d-%H:%M:%S:%s').html
    local data=$tmp

    curl --max-time 10 "$url" > $tmp 2>>/dev/null
    >&2 echo $tmp

    grep -q '<font color=red>' $tmp
    if [ $? ]
    then
        echo "До вышки НЕ достучаться"
        grep '<center>' $data | grep '<h2>' | sed -e 's/<b>/\n<b>/g' | sed -E "s/<\/*[a-z]*[0-9]*>//g"
    else
        echo "Ща найдем"
    fi
}



case "$1" in
    "tm" )
        echo get_weather_from_yandex_for "https://yandex.ru/pogoda/?lat=55.01266479&lon=36.46134567"
             get_weather_from_yandex_for "https://yandex.ru/pogoda/?lat=55.01266479&lon=36.46134567"
        ;;
    "to" )
        echo get_weather_from_yandex_for_Obninsk
             get_weather_from_yandex_for_Obninsk
        ;;
    "tk" )
        echo get_weather_from_yandex_for "https://yandex.ru/pogoda/?lat=53.93494797&lon=37.92854691"
             get_weather_from_yandex_for "https://yandex.ru/pogoda/?lat=53.93494797&lon=37.92854691"
        ;;
esac
