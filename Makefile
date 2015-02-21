DOCKER_USERNAME=dawi2332
DOCKER_NAME=postfix
DOCKER_TAG=$(DOCKER_USERNAME)/$(DOCKER_NAME)

.PHONY=all deps build

all:

deps:

push: build
	docker push $(DOCKER_TAG)

run: build
	docker run -p 25:25 -p 587:587 --rm -it -h smtp.x44.email --name postfix2 $(DOCKER_TAG)

build: deps
	docker build -t $(DOCKER_TAG) .

