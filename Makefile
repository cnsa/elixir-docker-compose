DOCKER_CMD := ./compose.sh
RELEASE_CMD := ./release.sh

install:
	mix deps.get

run:
	mix phoenix.server

mix_release:
	MIX_ENV=prod mix release

release:
	${RELEASE_CMD} ${ARGS}

drun: docker_run

deploy: release build compose

build:
	${DOCKER_CMD} build ${ARGS}

compose:
	${DOCKER_CMD} up -d ${ARGS}

scale:
	${DOCKER_CMD} scale ${ARGS}

pull:
	${DOCKER_CMD} pull ${ARGS}

down:
	${DOCKER_CMD} down ${ARGS}

logs:
	${DOCKER_CMD} logs ${ARGS}

docker_run:
	${DOCKER_CMD} run ${ARGS}

iex:
	iex -S mix

.PHONY: release
