FROM python:3.11-slim

RUN pip install --no-cache-dir poetry==2.2.1

WORKDIR /app

COPY pyproject.toml poetry.lock ./

RUN poetry config virtualenvs.create false && \
    poetry install --only main --no-root --no-interaction

COPY api-gateway.py .
RUN useradd --uid 10001 appuser
USER 10001
EXPOSE 8001

CMD ["python", "api-gateway.py"]