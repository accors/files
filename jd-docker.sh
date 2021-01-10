#!/bin/bash
set -e
JD_PATH=""
SHELL_FOLDER=$(pwd)
CONTAINER_NAME=""

log() {
    echo -e "\e[32m$1 \e[0m\n"
}

warn() {
    echo -e "\e[31m$1 \e[0m\n"
}

cancelrun() {
    if [ $# -gt 0 ]; then
        echo -e "\033[31m $1 \033[0m"
    fi
    exit 1
}

function docker_install() {
    echo "检查Docker......"
    if [ -x "$(command -v docker)" ]; then
       echo "检查到Docker已安装!"
    else
       if [ -r /etc/os-release ]; then
            lsb_dist="$(. /etc/os-release && echo "$ID")"
        fi
        if [ $lsb_dist == "openwrt" ]; then
            echo "openwrt 环境请自行安装docker"
            #exit 1
        else
            echo "安装docker环境..."
            curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
            echo "安装docker环境...安装完成!"
        fi
    fi
}

docker_install

echo -n -e "\e[33m请输入配置文件保存的绝对路径,直接回车为当前目录:\e[0m"
read jd_path
JD_PATH=$jd_path
if [ -z "$jd_path" ]; then
    JD_PATH=$SHELL_FOLDER
fi

config_path=$JD_PATH/jd_docker/config
log_path=$JD_PATH/jd_docker/log
log "1.开始创建配置文件目录"
mkdir -p $config_path
mkdir -p $log_path

log "2.开始下载配置文件"
wget -q --no-check-certificate https://gitee.com/evine/jd-base/raw/v3/sample/config.sh.sample -O $config_path/config.sh
if [ $? -ne 0 ]; then
    cancelrun "下载配置文件出错请重试"
fi

wget -q --no-check-certificate https://gitee.com/evine/jd-base/raw/v3/sample/docker.list.sample -O $config_path/crontab.list
if [ $? -ne 0 ]; then
    cancelrun "下载配置文件出错请重试"
fi

echo -n -e "配置文件config.sh已经下载到$config_path目录下，你可以手动去修改config.sh中的配置，也可以在这里输入第一个cookie:\n[Cookie的具体形式（只有pt_key字段和pt_pin字段，没有其他字段）：pt_key=xxxxxxxxxx;pt_pin=xxxx;]\n\e[33mCookie1->\e[0m"
read cookie

if [ -z "$cookie" ]; then
    warn "您没有输入cookie,请手动去$config_path/config.sh中修改"
else
    sed -i 's/Cookie1=""/Cookie1="'$cookie'"/g' $config_path/config.sh
fi

echo -n -e "请输入server酱的PUSH_KEY\n[ServerChan，教程：http://sc.ftqq.com/3.version]\n\e[33mPUSH_KEY->\e[0m"
read pushKey

if [ -z "$pushKey" ]; then
    warn "您没有输入PUSH_KEY,所以不会接收推送消息，如有需要可以手动去$config_path/config.sh中修改。\n也可以使用其他推送如：BARK\Telegram\钉钉\iGot聚合推送\酷推\Push Plus等，config.sh中有详细说明"
else
    sed -i 's/export PUSH_KEY=""/export PUSH_KEY="'$pushKey'"/g' $config_path/config.sh
fi

echo -n -e "\e[33m请输入要创建的 docker container 的名称[默认为：jd-script]->\e[0m"
read container_name
if [ -z "$container_name" ]; then
    CONTAINER_NAME="jd-script"
else
    CONTAINER_NAME=$container_name
fi

log "3.开始创建容器并执行"
docker run -dit \
    -v $config_path:/jd/config \
    -v $log_path:/jd/log \
    -p 5678:5678 \
    --name $CONTAINER_NAME \
    --hostname jd \
    --restart always \
    --network host \
    evinedeng/jd:gitee

log "4.是否安装containrrr/watchtower自动更新Docker容器：\n1) 安装[默认]\n2) 不安装"
echo -n -e "\e[33m输入您的选择->\e[0m"
read watchtower
if [ -z "$watchtower" ] || [ "$watchtower" == "1" ]; then
    docker run -d \
    --name watchtower \
    -v /var/run/docker.sock:/var/run/docker.sock \
    containrrr/watchtower
fi

log "5.docker容器已经运行,下面列出所有在运行的容器"

docker ps


log "6.接下来你可以选择：\n1) 退出[默认]\n2) 立刻执行京豆变动检测脚本进行测试"
echo -n -e "\e[33m输入您的选择->\e[0m"
read action
if [ "$action" == "2" ]; then
    docker exec $CONTAINER_NAME bash jd  bean_change now
else
    log "即将退出脚本！"
    exit 1
fi
