DOCKER_CMD := docker-compose -f docker-compose.yml

install:
	mix deps.get

run:
	mix phoenix.server

drun: docker_run

build:
	${DOCKER_CMD} build ${ARGS}

compose:
	${DOCKER_CMD} up -d ${ARGS}

scale:
	${DOCKER_CMD} scale ${ARGS}

logs:
	${DOCKER_CMD} logs ${ARGS}

docker_run:
	${DOCKER_CMD} run ${ARGS}

iex:
	iex -S mix
