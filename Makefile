bash:
	docker-compose run --service-ports  devshell

build:
	docker-compose build devshell

root_shell:
	docker-compose run --user root --service-ports devshell
