all: build
	echo "Done"

build: Dockerfile
	docker -t stainlessio/esp-idf build .

push: build
	docker push stainlessio/esp-idf