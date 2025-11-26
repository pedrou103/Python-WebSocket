# 1. Usar python slim e definir diretório de trabalho
FROM python:3.11-slim

# 2. Definir variável de ambiente para não gerar arquivos .pyc
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 3. Instalar dependências do sistema necessárias para algumas libs Python
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 4. Criar diretório de trabalho
WORKDIR /app

# 5. Copiar apenas requirements.txt primeiro (isso usa cache do Docker)
COPY requirements.txt .

# 6. Instalar dependências Python
RUN pip install --no-cache-dir -r requirements.txt

# 7. Copiar só o que é necessário para rodar o app
COPY app.py .
COPY templates/ ./templates
COPY static/ ./static

# 8. Comando para iniciar o app
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:10000"]
