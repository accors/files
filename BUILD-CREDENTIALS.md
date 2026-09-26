# 私有仓库构建凭据

历史提交中的 SSH 私钥已撤销或确认失效，当前构建不再接受私钥 build arg，也不会把私钥写入镜像。

使用有目标私有仓库只读权限的新密钥，在本机 SSH agent 中加载后构建：

```sh
ssh-add /安全目录/新构建密钥
docker buildx build --ssh default -f v4.Dockerfile .
```

SSH agent 只转发到执行 `git clone` 的独立构建步骤。后续依赖安装步骤不能访问该 agent，镜像中不包含私钥。

如果运行中的容器需要拉取私有仓库，请另外提供运行期凭据：`/root/.ssh/jd_shell` 与 `/root/.ssh/jd_backup`。使用只读 bind mount 或部署平台的 secret，不要把凭据放入构建上下文。变更过对应目录名 build arg 时，挂载位置须与生成的 SSH Host 配置一致。

回归检查：

```sh
python3 -m unittest discover -s tests -p test_private_keys.py
```

旧提交与旧镜像可能仍保存已失效的私钥。源码修复不会改写 Git 历史，也不会删除已发布镜像；需要保留旧镜像用于回滚时，应先确认相关密钥已失效。

