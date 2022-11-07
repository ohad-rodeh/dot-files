all : barc_dev

barc_dev: build_homedir
	docker build -t barc_dev .
	docker run --name barc_box --privileged \
	   --volume /tmp:/tmp \
	-it barc_dev

#
#	   --volume /Users/orodeh/U:/root/U
#

build_homedir:
	rm -rf homedir
	cp -r ../USER_HOME_DIR homedir
	cp -r ~/.ssh homedir/

stop:
	docker stop barc_box  || true
	docker rm barc_box || true
