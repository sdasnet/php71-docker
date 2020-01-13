#!make

build:
	docker build . -t php71-docker

run:
	docker run -d -p 80:80 --name my-laravel-app -v "$PWD":/var/www php71-docker

up:
	docker-compose up -d --build

push:
	docker tag php71-docker jpswade/php71-docker
	docker push jpswade/php71-docker

bash:
	docker run -it --entrypoint bash php71-docker

exec:
	docker-compose exec web bash
