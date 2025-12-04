# TEMPLATE - PHP/DOCKER/XAMPP
## Template Padrão para PHP

### Makefile 

Comandos disponíveis para facilitar o uso do Docker e do ambiente PHP. Exemplos de uso: `make init`, `make up`, etc.

- `init` — Fluxo inicial completo: garante `.env`, executa `build`, sobe os containers (`up`) e instala as dependências PHP (`composer-install`).
- `env` — Cria `.env` a partir de `.env.example` se ainda não existir.
- `build` — Faz o build das imagens Docker definidas no `docker-compose.yml`.
- `up` — Sobe todos os serviços em segundo plano (detached).
- `down` — Derruba os containers, mantendo volumes e imagens.
- `down-v` — Derruba containers e remove volumes, imagens órfãs e serviços não usados (reset mais agressivo).*Use com cuidado.*
- `reset-template-global` — Zera o projeto para reuso como template: derruba tudo e remove `vendor`, `node_modules`, lockfiles e `.env`.
- `logs` — Segue os logs do serviço `app`.
- `bash` — Abre um shell dentro do container `app`.
- `ps` — Lista o estado dos containers.
- `composer-install` — Instala dependências PHP (roda `composer install` dentro do container).
- `composer-update` — Atualiza dependências PHP (roda `composer update`).
- `composer-dump-autoload` — Gera autoload otimizado do Composer.
- `help` — Mostra um resumo dos comandos disponíveis.

Para ver este resumo no terminal, execute `make help`.




