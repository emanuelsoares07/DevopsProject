#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho no container
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Se o requirements.txt não mudar, o Docker não reinstalará as dependências.
COPY requirements.txt .

# Instala as dependências
# --no-cache-dir: Desativa o cache, o que pode reduzir o tamanho da imagem.
# --upgrade pip: Garante que temos a versão mais recente do pip.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta 8000 para o mundo fora deste container
EXPOSE 8000

# Define o comando para executar a aplicação quando o container iniciar.
# Usamos 0.0.0.0 para tornar a aplicação acessível de fora do container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
