# Usa Python 3.11
FROM python:3.11-slim

# Define diretório de trabalho
WORKDIR /app

# Copia e instala as dependências
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo o projeto
COPY . .

# Expõe a porta que o Render vai usar
EXPOSE 10000

# Comando para iniciar a aplicação com Eventlet
CMD ["gunicorn", "-k", "eventlet", "-w", "1", "app:app", "--bind", "0.0.0.0:10000"]
