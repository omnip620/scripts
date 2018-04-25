#!/bin/bash
function parse_yaml {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

eval $(parse_yaml $1 $2)

set auth_basic
set auth_basic_user_file
set password
if [[ $auth_enable == "on" ]] ; then
  auth_str="auth_basic \"Restricted\";"
  auth_basic_user_file="auth_basic_user_file ${root}/.htpasswd;"
  password=$(perl -e 'print crypt($ARGV[0], "pwdsalt")' ${auth_pwd})
  echo "$auth_name:$password"
cat >${root}/.htpasswd<< EOF
  $auth_name:$password
EOF
fi

cat  << EOF
server {
    listen ${port};
    charset utf-8;
    server_name ${domain};
    default_type 'text/html';
    root ${root};
    location / {
      ${auth_str}
      ${auth_basic_user_file}
      fancyindex on;
      fancyindex_exact_size off;
      fancyindex_localtime on;
    }
}
EOF
