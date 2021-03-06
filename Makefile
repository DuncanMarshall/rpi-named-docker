DOCKER_IMAGE_NAME=tenstartups/rpi-named

build: Dockerfile
	docker build -t ${DOCKER_IMAGE_NAME} .

clean_build: Dockerfile
	docker build --no-cache=true -t ${DOCKER_IMAGE_NAME} .

push: build
	docker push ${DOCKER_IMAGE_NAME}

run: build
	docker run -it --rm ${DOCKER_IMAGE_NAME} ${ARGS}

