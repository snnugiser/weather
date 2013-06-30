#!/bin/bash
source /etc/profile
source /home/GISer/.bash_profile
source /home/GISer/.bashrc
#source /home/GISer/.muttrc

#export PATH=$PATH:/home/GISer
#export PATH=$PATH:/opt/msmtp/bin

city="江苏南京"
city_code=101190101 #默认城市为南京
read city_all < city.code
OLD_IFS="$IFS"
IFS="|"
arr=($city_all)
OLD_IFS="$IFS"
IFS="$OLD_IFS"
arr=($city_all)
IFS="$OLD_IFS"
for s in ${arr[@]}
do
    city_name=${s%,*}
    if [ "$city_name"x = "$city"x ];then
        city_code=${s#*,}
    fi
done
default_code=101050101
add="http://m.weather.com.cn/data/101050101.html"
add=${add/$default_code/$city_code}
weather_info=$(curl -k $add)
temp=${weather_info#*\"city\":\"*}
city_cn=${temp%%\",\"*}
temp=${temp#*\"date_y\":\"*}
date_y=${temp%%\",\"*}
temp=${temp#*\"week\":\"*}
week=${temp%%\",\"*}
temp=${temp#*\"cityid\":\"*}
cityid=${temp%%\",\"*}
temp=${temp#*\"temp1\":\"*}
temp1=${temp%%\",\"*}
temp=${temp#*\"temp2\":\"*}
temp2=${temp%%\",\"*}
temp=${temp#*\"temp3\":\"*}
temp3=${temp%%\",\"*}
temp=${temp#*\"temp4\":\"*}
temp4=${temp%%\",\"*}
temp=${temp#*\"temp5\":\"*}
temp5=${temp%%\",\"*}
temp=${temp#*\"temp6\":\"*}
temp6=${temp%%\",\"*}
temp=${temp#*\"weather1\":\"*}
weather1=${temp%%\",\"*}
temp=${temp#*\"weather2\":\"*}
weather2=${temp%%\",\"*}
temp=${temp#*\"weather3\":\"*}
weather3=${temp%%\",\"*}
temp=${temp#*\"weather4\":\"*}
weather4=${temp%%\",\"*}
temp=${temp#*\"weather5\":\"*}
weather5=${temp%%\",\"*}
temp=${temp#*\"weather6\":\"*}
weather6=${temp%%\",\"*}
temp=${temp#*\"wind1\":\"*}
wind1=${temp%%\",\"*}
temp=${temp#*\"wind2\":\"*}
wind2=${temp%%\",\"*}
temp=${temp#*\"wind3\":\"*}
wind3=${temp%%\",\"*}
temp=${temp#*\"wind4\":\"*}
wind4=${temp%%\",\"*}
temp=${temp#*\"wind5\":\"*}
wind5=${temp%%\",\"*}
temp=${temp#*\"wind6\":\"*}
wind6=${temp%%\",\"*}

temp=${temp#*\"fl1\":\"*}
fl1=${temp%%\",\"*}
temp=${temp#*\"fl2\":\"*}
fl2=${temp%%\",\"*}
temp=${temp#*\"fl3\":\"*}
fl3=${temp%%\",\"*}
temp=${temp#*\"fl4\":\"*}
fl4=${temp%%\",\"*}
temp=${temp#*\"fl5\":\"*}
fl5=${temp%%\",\"*}
temp=${temp#*\"fl6\":\"*}
fl6=${temp%%\",\"*}

temp=${temp#*\"index_d\":\"*}
#穿衣指数
index_d=${temp%%\",\"*}
temp=${temp#*\"index_48_d\":\"*}
#48小时穿衣指数
index_48_d=${temp%%\",\"*}
temp=${temp#*\"index_ag\":\"*}
#感冒指数
index_ag=${temp%\"\}\}}
subject="天气预报"
maintext=$city_cn"今天到明天,"$weather1,$temp1,$wind1,$index_d
maintext=$maintext"明天到后天,"$weather2,$temp2,$wind2,$index_48_d
maintext=$maintext"第三天到第六天天气分别为:"
maintext=$maintext$weather3","$temp3";"
maintext=$maintext$weather4","$temp4";"
maintext=$maintext$weather5","$temp5";"
maintext=$maintext$weather6","$temp6"."
if [ $city_name"x" = $city"x" ];then
[else
    maintext="获取参数不正确"]
fi
echo $maintext | /opt/mutt/bin/mutt -s $subject -F /home/GISer/.muttrc 13207198298@139.com

