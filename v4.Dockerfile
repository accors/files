FROM alpine:latest
ARG REPO=gitee
ARG REPO_URL=$REPO.com
ARG JD_SCRIPTS=jd_backup
ARG JD_SCRIPTS_BRANCH=master
ARG JD_SCRIPTS_HOST=jd_scripts_acc
ARG JD_SCRIPTS_KEY="-----BEGIN OPENSSH PRIVATE KEY-----\n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\n-----END OPENSSH PRIVATE KEY-----"
ARG JD_SHELL=jd_shell
ARG JD_SHELL_BRANCH=master
ARG JD_SHELL_HOST=jd_shell_acc
ARG JD_SHELL_URL=git@jd_shell_acc:accors/jd_shell.git
ARG JD_SHELL_KEY="-----BEGIN OPENSSH PRIVATE KEY-----\n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\n-----END OPENSSH PRIVATE KEY-----"
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
    && echo $JD_SHELL_KEY | perl -pe "{s|_| |g; s|@|\n|g}" > /root/.ssh/$JD_SHELL \
    && echo $JD_SCRIPTS_KEY | perl -pe "{s|_| |g; s|@|\n|g}" > /root/.ssh/$JD_SCRIPTS \
    && chmod 600 /root/.ssh/$JD_SHELL /root/.ssh/$JD_SCRIPTS \
    && echo -e "Host $JD_SHELL_HOST\n\tHostname $REPO_URL\n\tIdentityFile=/root/.ssh/$JD_SHELL\n\nHost $JD_SCRIPTS_HOST\n\tHostname $REPO_URL\n\tIdentityFile=/root/.ssh/$JD_SCRIPTS" > /root/.ssh/config \
    && echo -e "\n\nHost *\n  StrictHostKeyChecking no\n" >> /etc/ssh/ssh_config \
    && chmod 644 /root/.ssh/config \
    && ssh-keyscan $REPO_URL > /root/.ssh/known_hosts \
    ##&& git config --global pull.ff only \
    && git clone -b $JD_SHELL_BRANCH $JD_SHELL_URL $JD_DIR \
    && echo "========= 安装PM2 =========" \
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