<?php

declare(strict_types=1);

use Dotenv\Dotenv;

session_start(); # Inicia a sessão

require __DIR__ . '/../vendor/autoload.php';

// Caminho base do projeto
define('BASE_PATH', dirname(__DIR__));

// Carrega variáveis de ambiente
$dotenv = Dotenv::createImmutable(dirname(__DIR__));
$dotenv->safeLoad();

// Configura timezone
date_default_timezone_set($_ENV['APP_TIMEZONE'] ?? 'UTC');

// Encoding padrão
mb_internal_encoding('UTF-8');

// Configura erros conforme APP_DEBUG
$debug = filter_var($_ENV['APP_DEBUG'] ?? false, FILTER_VALIDATE_BOOLEAN);

error_reporting($debug ? E_ALL : E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED);
ini_set('display_errors', $debug ? '1' : '0');
ini_set('display_startup_errors', $debug ? '1' : '0');
