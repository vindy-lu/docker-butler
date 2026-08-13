FROM python:3.12-slim

LABEL maintainer="docker-butler"

# 安装系统依赖（docker-cli + docker-compose，用于容器内执行 compose 管理项目）
RUN apt-get update && apt-get install -y --no-install-recommends \
    docker-cli \
    docker-compose \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 安装Python依赖
COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制后端代码
COPY backend/ .

# 复制前端静态文件
COPY frontend/ /app/frontend/

# 数据目录
RUN mkdir -p /data

ENV DB_PATH=/data/docker-butler.db
ENV APP_PORT=8383

EXPOSE 8383

CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${APP_PORT:-8383} --log-level info"]
