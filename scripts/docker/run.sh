#!/bin/bash

[ "$architecture" == "amd64" ] && image=linuxserver/bookstack
[ -z $image ] && ynh_die "Sorry, your $architecture architecture is not supported ..."

options="-p $port:80 -v $data_path/data:/config -e PUID=0 -e PGID=0 -e DB_HOST=localhost -e DB_USER=__DB_USER__ -e DB_PASS=__DB_PWD__ -e DB_DATABASE=__DB_USER__ -e APP_URL=https://__URL__"

iptables -t filter -N DOCKER 

docker run -d --name=$app --restart always $options $image 1>&2
CR=$?

echo $CR
