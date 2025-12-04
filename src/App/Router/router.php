<?php

declare(strict_types=1);

function routes() :array
{
    return [
        '/' => 'HomeController@index',
        '/user/create' => 'UserController@create',
    ];
}

function router() : void
{
    $uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
    $routes = routes();

    if (array_key_exists($uri, $routes)) {
        dd('Acho aqui:' . $uri);
    }
}
