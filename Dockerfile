# ✅ FastMCP 공식 베이스 이미지와 동일한 Python 버전 사용
FROM python:3.12-slim

WORKDIR /app

# ---------- 의존성 설치 ----------
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
RUN pip install --no-cache-dir .

# ---------- 환경 변수 ----------
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONPATH=/app     # 🔥 핵심: FastMCP가 wikipedia_mcp 패키지를 찾을 수 있도록 보장

# ---------- MCP 설정 ----------
EXPOSE 8080

# MCP 서버 진입점: FastMCP가 __main__.py를 통해 실행하도록 지정
ENTRYPOINT ["python", "-m", "wikipedia_mcp"]

CMD ["--log-level", "INFO"]

# ---------- 메타데이터 ----------
LABEL org.opencontainers.image.title="Wikipedia MCP Server"
LABEL org.opencontainers.image.description="Model Context Protocol server for Wikipedia integration"
LABEL org.opencontainers.image.url="https://github.com/sophus1004/agent-wikipedia-mcp"
LABEL org.opencontainers.image.source="https://github.com/sophus1004/agent-wikipedia-mcp"
LABEL org.opencontainers.image.version="1.6.0"
LABEL org.opencontainers.image.authors="Tom <tom@diquest.com>"
LABEL org.opencontainers.image.licenses="MIT"