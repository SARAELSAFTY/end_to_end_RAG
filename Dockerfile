FROM python:3.11-slim

WORKDIR / app

RUN apt-get update && apt-get install -y curl tesseract-ocr && rm -rf /var/lib/apt/lists/*

RUN curl -LsSF https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"

COPY pyproject.toml uv.lock ./

RUN uv sync --frozen

COPY . .

EXPOSE 8501

CMD ["uv","run","streamlit", "run", "app/streamlitApp.py", "--server.port=8501", "--server.address=0.0.0.0"]