# Alias para o Docker Compose
DC = docker compose

# Alvos que não geram arquivos
.PHONY: \
	init env build up down down-v restart \
	reset-template-global \
	logs bash ps \
	composer-install composer-update help

# Fluxo completo de primeira vez:
# - garante .env
# - builds imagens
# - sobe containers
# - instala dependências PHP dentro do container
init:
	@echo ">>> Criando .env (se necessário)..."
	$(MAKE) env

	@echo ">>> Buildando containers..."
	$(MAKE) build

	@echo ">>> Subindo containers..."
	$(MAKE) up

	@echo ">>> Instalando dependências PHP..."
	$(MAKE) composer-install

	@echo ">>> Ambiente pronto!"

# Garante que existe um .env baseado no .env.example
env:
	@echo ">>> Verificando .env..."
	@test -f .env || cp .env.example .env

# Build das imagens Docker (app, etc.)
build:
	@echo ">>> Buildando imagens Docker..."
	$(DC) build

# Sobe todos os serviços em segundo plano
up:
	@echo ">>> Subindo containers..."
	$(DC) up -d

# Derruba todos os containers, mantendo volumes e imagens
down:
	@echo ">>> Derrubando containers (sem apagar volumes/imagens)..."
	$(DC) down

# Derruba containers, apaga volumes, remove imagens e órfãos
down-v:
	@echo ">>> Derrubando containers + volumes + imagens órfãs..."
	$(DC) down -v --rmi all --remove-orphans

# RESET TOTAL DE TEMPLATE:
# - pensado para reusar este repositório como TEMPLATE
# - remove dependências, lockfiles e .env
# - não recria nada automaticamente (usuário roda 'make init' depois)
reset-template-global:
	@echo ">>> [reset-template-global] Derrubando containers, volumes e imagens..."
	$(DC) down -v --rmi all --remove-orphans

	@echo ">>> [reset-template-global] Removendo dependências e lockfiles..."
	rm -rf vendor
	rm -rf node_modules
	rm -f composer.lock
	rm -f package-lock.json
	rm -rf .phpunit.result.cache
	rm -f .env

	@echo ">>> [reset-template-global] Projeto zerado."
	@echo ">>> Agora execute: make init"

# Logs em tempo real do container app
logs:
	$(DC) logs -f app

# Entra no container app via bash
bash:
	$(DC) exec app bash

# Lista o estado dos containers
ps:
	$(DC) ps

# Composer via 'run' (não depende de app estar saudável)
composer-install:
	@echo ">>> Instalando dependências PHP (composer install)..."
	$(DC) run --rm app sh -c "composer install --no-interaction --prefer-dist --optimize-autoloader"

composer-update:
	@echo ">>> Atualizando dependências PHP (composer update)..."
	$(DC) run --rm app sh -c "composer update"

composer-dump-autoload:
	@echo ">>> Gerando autoload otimizado (composer dump-autoload)..."
	$(DC) run --rm app sh -c "composer dump-autoload --optimize"

# Ajuda rápida
help:
	@echo "Comandos disponíveis:"
	@echo "  make init                   - Primeiro setup: env + build + up + composer-install"
	@echo "  make up                     - Sobe os containers"
	@echo "  make down                   - Derruba containers (mantém volumes/imagens)"
	@echo "  make down-v                 - Derruba containers + volumes + imagens órfãs"
	@echo "  make reset-template-global  - Zera tudo para reusar como TEMPLATE"
	@echo "  make composer-install       - Instala dependências PHP"
	@echo "  make composer-update        - Atualiza dependências PHP"
	@echo "  make composer-dump-autoload - Gera autoload otimizado"
	@echo "  make logs                   - Logs do app"
	@echo "  make bash                   - Entra no container app"
	@echo "  make ps                     - Lista containers"

