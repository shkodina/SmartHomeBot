#!/usr/bin/env bash



function get_weather_from_yandex_for_Maloyaroslavec () {
    local yandex_url="https://yandex.ru/pogoda/?lat=55.01266479&lon=36.46134567"
    local tmp=/tmp/curl-from-yandex-$(date '+%Y.%m.%d-%H:%M:%S:%s').html
    local data=$tmp.sed

    curl "$yandex_url" > $tmp 2>>/dev/null
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

}



case "$1" in
    "tm" )
        echo get_weather_from_yandex_for_Maloyaroslavec
        ;;
    "to" )
        echo get_weather_from_yandex_for_Obninsk
        ;;
    "tk" )
        echo get_weather_from_yandex_for_Keereyevsk
        ;;
esac
