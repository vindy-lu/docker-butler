# Docker Butler 🐳

Docker 容器管理面板：**定时启停、一键更新镜像、Compose 项目管理**，全在一个网页里完成。适配各类 NAS（飞牛/群晖/绿联/威联通）和任何 Linux + Docker 环境。

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## 功能一览

| 能力 | 说明 |
| --- | --- |
| 容器管理 | 容器列表、CPU/内存/网络 I/O 实时监控、端口直达链接、一键启停/重启/删除 |
| 定时调度 | Cron 表达式定时启停/重启/更新，支持自然语言描述，Compose 项目级调度 |
| 镜像更新 | 自动检测远程新版本，一键更新（实时进度条） |
| Compose 项目 | 自动识别全部 Compose 项目，项目级启停/更新，内存占用排序，网页新建项目 |
| 镜像管理 | 批量清理未使用/悬空镜像、镜像加速器配置、本地 tar 导入 |
| 面板自更新 | 面板内一键升级自己 |
| 账号安全 | 2FA 双重认证（TOTP）、信任设备、修改密码 |

## 快速开始

新建 `docker-compose.yml`：

```yaml
services:
  docker-butler:
    image: ghcr.io/vindy-lu/docker-butler:latest
    container_name: docker-butler
    privileged: true
    pid: host
    ports:
      - "54321:8383"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./docker-butler-data:/data
      - /etc/docker/daemon.json:/etc/docker/daemon.json
      - ${COMPOSE_ROOT:-/vol1/1000/Docker}:/host/compose
      - ${COMPOSE_VOLUME_ROOT:-/vol1}:/host-vol1
    environment:
      - TZ=Asia/Shanghai
      - DB_PATH=/data/docker-butler.db
      - APP_PORT=8383
      - COMPOSE_ROOT_HOST=${COMPOSE_ROOT:-/vol1/1000/Docker}
      - COMPOSE_VOLUME_ROOT_HOST=${COMPOSE_VOLUME_ROOT:-/vol1}
    restart: unless-stopped
```

```bash
docker compose up -d
```

浏览器访问 `http://你的IP:54321`，默认账号 `admin` / `admin`，首次登录后请立即修改密码。

> **NAS 路径参考**：飞牛 `/vol1`，群晖/绿联 `/volume1`，威联通 `/share`。按你的 NAS 替换上方 `${...}` 默认值即可。
> **Snap 版 Docker（Ubuntu 预装）**：只能挂载 `$HOME` 下目录，请把所有路径放到 `/home/用户名/` 下。

## 界面预览

| 容器详情 | Compose 项目 |
| --- | --- |
| <img src="docs/配图/02-容器详情.png" width="460"> | <img src="docs/配图/06-Compose项目.png" width="460"> |

| 定时调度 | 账号安全 |
| --- | --- |
| <img src="docs/配图/03-定时调度.png" width="460"> | <img src="docs/配图/08-账号安全.png" width="460"> |

## 技术栈

FastAPI + Vue 3 (Element Plus) + SQLite + Docker SDK，单容器部署，无外部依赖。

## 反馈

使用中遇到问题欢迎提 [Issue](https://github.com/vindy-lu/docker-butler/issues)，或加入 QQ 群交流。

## License

MIT
