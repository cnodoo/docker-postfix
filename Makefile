DOCKER_USERNAME=dawi2332
DOCKER_NAME=postfix
DOCKER_TAG=$(DOCKER_USERNAME)/$(DOCKER_NAME)

.PHONY=all deps build

all:

deps: dh2048.pem

dh2048.pem:
	openssl dhparam -out dh2048.tmp 2048 && mv dh2048.tmp $@
	chmod 644 $@

push: build
	docker push $(DOCKER_TAG)

run: build
	docker run -p 25:25 -p 587:587 --rm -it -h not-smtp.x44.email --name postfix2 $(DOCKER_TAG)

build: deps
	docker build -t $(DOCKER_TAG) .

