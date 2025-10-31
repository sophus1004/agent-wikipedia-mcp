# ✅ Python 3.12 권장 (FastMCP는 Python 3.12 기반 이미지와 호환)
FROM python:3.12-slim

# 작업 디렉터리 설정
WORKDIR /app

# 의존성 먼저 복사 (빌드 캐시 최적화)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 전체 소스 복사
COPY . .

# 로컬 패키지 설치 (setup.cfg / pyproject.toml 기반)
RUN pip install --no-cache-dir .

# 환경 변수 설정
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# MCP 기본 포트
EXPOSE 8080

# ✅ MCP 서버 엔트리포인트 (모듈 실행)
# FastMCP는 Python 모듈 형태로 진입점 지정 필요
ENTRYPOINT ["python", "-m", "wikipedia_mcp"]

# 기본 실행 옵션 (선택사항)
CMD ["--log-level", "INFO"]

# 메타데이터 라벨
LABEL org.opencontainers.image.title="Wikipedia MCP Server"
LABEL org.opencontainers.image.description="Model Context Protocol server for Wikipedia integration"
LABEL org.opencontainers.image.url="https://github.com/sophus1004/agent-wikipedia-mcp"
LABEL org.opencontainers.image.source="https://github.com/sophus1004/agent-wikipedia-mcp"
LABEL org.opencontainers.image.version="1.6.0"
LABEL org.opencontainers.image.authors="Tom <tom@diquest.com>"
LABEL org.opencontainers.image.licenses="MIT"