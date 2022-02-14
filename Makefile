all: build

build:
	docker build -t telegabber:latest -f Dockerfile --no-cache=true .
build_dev:
	docker build -t telegabber:latest -f Dockerfile_dev --no-cache=true .
build_libs:
	docker build -t telegabber-libs:latest -f Dockerfile_libs --no-cache=true .
upload:
	docker tag telegabber:latest nulldevil/telegabber:latest
	docker push nulldevil/telegabber:latest
up:
	COMPOSE_PROJECT_NAME=telegabber COMPOSE_IGNORE_ORPHANS=True docker-compose -f telegabber.yml up -d
down:
	COMPOSE_PROJECT_NAME=telegabber COMPOSE_IGNORE_ORPHANS=True docker-compose -f telegabber.yml down
clean:
	docker image prune -a -f
	docker volume prune -f
	docker network prune -f
	docker system prune --volumes -f
