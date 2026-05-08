FROM apache/superset:latest-dev

USER root

RUN apt-get update && \
    apt-get install -y libpq-dev gcc && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && \
    pip uninstall -y psycopg2-binary && \
    pip install psycopg2 && \
    pip install thrift

# Crear carpeta superset_home con permisos para el usuario superset
RUN mkdir -p /app/superset_home && chown -R superset:superset /app/superset_home

# Copiar entrypoint
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

USER superset

# Establecer el entrypoint por defecto
ENTRYPOINT ["/app/entrypoint.sh"]

