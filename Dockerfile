FROM python:3.10.5-slim-bullseye AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
  PIP_NO_CACHE_DIR=1 \
  PIP_DEFAULT_TIMEOUT=100 \
  POETRY_VIRTUALENVS_CREATE=false \
  PATH=$PATH:/root/.local/bin

# renovate: datasource=pypi depName=poetry
ENV POETRY_VERSION=1.1.10

RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py \
  | python -

WORKDIR /app

COPY pyproject.toml poetry.lock ./

RUN python -m venv --copies /app/venv

ARG GITLAB_PYPI_SECRET_NAME
ARG GITLAB_PYPI_SECRET

RUN poetry config http-basic.gitlab-pypi ${GITLAB_PYPI_SECRET_NAME} ${GITLAB_PYPI_SECRET}

RUN . /app/venv/bin/activate && poetry install --no-dev --no-interaction --no-ansi


FROM python:3.10.5-slim-bullseye AS run

WORKDIR /app

RUN groupadd -r -g 42000 app \
  && useradd --no-log-init -r -u 42000 -g app app \
  && chown -R app:app ./ \
  && chmod 755 ./
USER app

ENV PYTHON_ENV=prod \
  PYTHONFAULTHANDLER=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONDONTWRITEBYTECODE=1 \
  PATH=$PATH:/app/venv/bin

COPY --chown=app:app --from=builder /app/venv venv/
COPY --chown=app:app showcase showcase

CMD ["uvicorn", "showcase.app:app", "--host", "0.0.0.0"]
