all: build

build:
	docker build -t telegabber:latest -f Dockerfile --no-cache=true .
build_libs:
	docker build -t telegabber-libs:latest -f Dockerfile_libs --no-cache=true .
up:
	COMPOSE_PROJECT_NAME=telegabber COMPOSE_IGNORE_ORPHANS=True docker-compose -f telegabber.yml up -d
down:
	COMPOSE_PROJECT_NAME=telegabber COMPOSE_IGNORE_ORPHANS=True docker-compose -f telegabber.yml down
