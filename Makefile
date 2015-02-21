DOCKER_USERNAME=dawi2332
DOCKER_NAME=postfix
DOCKER_TAG=$(DOCKER_USERNAME)/$(DOCKER_NAME)

.PHONY=all deps build

all:

deps: dh512.pem dh1024.pem dh2048.pem

dh512.pem:
	openssl dhparam -out dh512.tmp 512 && mv dh512.tmp $@
	chmod 644 $@

dh1024.pem:
	openssl dhparam -out dh1024.tmp 1024 && mv dh1024.tmp $@
	chmod 644 $@

dh2048.pem:
	openssl dhparam -out dh2048.tmp 2048 && mv dh2048.tmp $@
	chmod 644 $@

push: build
	docker push $(DOCKER_TAG)

run: build
	docker run -p 25:25 -p 587:587 --rm -it -h smtp.x44.email --name postfix2 $(DOCKER_TAG)

build: deps
	docker build -t $(DOCKER_TAG) .

