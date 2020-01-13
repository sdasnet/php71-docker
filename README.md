# PHP 7.1 + Apache for Laravel

This is a Dockerfile created from an earlier version, for PHP 5.6 ([Dockerfile-php56](https://gist.github.com/jpswade/9a45b66111adaa4222f4652c586616be)).

## Prerequisites

Install Docker Desktop (aka Docker for Mac)

- `brew install docker`

Docker Hub Login

- [Signup to Docker Hub](https://hub.docker.com/signup)
- `docker login`

## Building

- `docker build . -t php71-docker`

## Using Docker

- Shell: `docker run -it php71-docker bash`
- Server: `docker run -d -p 80:80 --name my-laravel-app -v "$PWD":/var/www php56-docker`

### Using Docker Compose

- `cp .env.example .env`
- `docker-compose up -d --build`

## Pushing

- `docker push jpswade/php71-docker`

## Troubleshooting

### The Xdebug extension is not loaded
- `docker-php-ext-enable xdebug`

## Maintainer

- [James Wade](https://wade.be/)
