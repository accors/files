# syntax=docker/dockerfile:1
FROM alpine:latest
ARG REPO=gitee
ARG REPO_URL=$REPO.com
ARG JD_SCRIPTS=jd_backup
ARG JD_SCRIPTS_BRANCH=master
ARG JD_SCRIPTS_HOST=jd_scripts_acc
ARG JD_SHELL=jd_shell
ARG JD_SHELL_BRANCH=master
ARG JD_SHELL_HOST=jd_shell_acc
ARG JD_SHELL_URL=git@jd_shell_acc:accors/jd_shell.git
COPY --from=nevinee/s6-overlay-stage:latest / /
COPY --from=nevinee/loop:latest / /
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    LANG=zh_CN.UTF-8 \
    SHELL=/bin/bash \
    PS1="\u@\h:\w \$ " \
    JD_DIR=/jd \
    ENABLE_HANGUP=false \
    ENABLE_RESET_REPO_URL=true \
    JD_SCRIPTS_URL=git@$JD_SCRIPTS_HOST:accors/$JD_SCRIPTS.git
WORKDIR $JD_DIR
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && echo "========= 安装软件 =========" \
    && apk update -f \
    && apk --no-cache add -f \
       bash \
       coreutils \
       diffutils \
       git \
       wget \
       curl \
       nano \
       tzdata \
       perl \
       openssh-client \
       nodejs-lts \
       npm \
    && echo "========= 修改时区 =========" \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && echo "========= 部署SSH KEY =========" \
    && mkdir -p /root/.ssh \
    && echo -e "Host $JD_SHELL_HOST\n\tHostname $REPO_URL\n\tIdentityFile=/root/.ssh/$JD_SHELL\n\nHost $JD_SCRIPTS_HOST\n\tHostname $REPO_URL\n\tIdentityFile=/root/.ssh/$JD_SCRIPTS" > /root/.ssh/config \
    && echo -e "\n\nHost *\n  StrictHostKeyChecking no\n" >> /etc/ssh/ssh_config \
    && chmod 644 /root/.ssh/config \
    && ssh-keyscan $REPO_URL > /root/.ssh/known_hosts
    ##&& git config --global pull.ff only \
RUN --mount=type=ssh,required=true git clone -b $JD_SHELL_BRANCH $JD_SHELL_URL $JD_DIR
RUN echo "========= 安装PM2 =========" \
    && npm install -g pm2@4.5.6 \
    && echo "========= 创建软链接 =========" \
    && ln -sf $JD_DIR/jtask.sh /usr/local/bin/jtask \
    && ln -sf $JD_DIR/jtask.sh /usr/local/bin/otask \
    && ln -sf $JD_DIR/jtask.sh /usr/local/bin/mtask \
    && ln -sf $JD_DIR/jup.sh /usr/local/bin/jup \
    && ln -sf $JD_DIR/jlog.sh /usr/local/bin/jlog \
    && ln -sf $JD_DIR/jcode.sh /usr/local/bin/jcode \
    && ln -sf $JD_DIR/jcsv.sh /usr/local/bin/jcsv \
    && if [ -d /etc/cont-init.d ]; then \
            rm -rf /etc/cont-init.d; \
       fi \
    && if [ -d /etc/services.d ]; then \
            rm -rf /etc/services.d; \
       fi \
    && ln -sf $JD_DIR/s6-overlay/etc/cont-init.d /etc/cont-init.d \
    && ln -sf $JD_DIR/s6-overlay/etc/services.d /etc/services.d \
    && echo "========= 清理 =========" \
    && rm -rf /root/.npm /var/cache/apk/*
ENTRYPOINT ["/init"]
