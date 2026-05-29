TOP=../..

all : run

build_homedir:
	rm -rf homedir
	mkdir -p homedir
	cp .emacs homedir/
	cp -r .emacs.d homedir/
	cp $(TOP)/.git-completion.bash homedir/
	cp $(TOP)/.profile homedir/
	cp $(TOP)/.bashrc homedir/
	cp  ~/.gitconfig homedir/
	cp  ~/.gitignore_global homedir/
	cp -r ~/.ssh homedir/
	cp -r ~/.aws homedir/

build: build_homedir
	docker build -t barc_dev_u26 .

run: build
	docker run --name barc_box_u26 \
	   --network host \
	   --privileged \
	   --volume /tmp:/tmp \
	   --volume /var/run/docker.sock:/var/run/docker.sock \
	   --mount source=rnd,destination=/rnd \
	-it barc_dev_u26

run_no_build:
	docker run --name barc_box_u26 \
	   --network host \
	   --privileged \
	   --volume /tmp:/tmp \
	   --volume /var/run/docker.sock:/var/run/docker.sock \
	   --mount source=rnd,destination=/rnd \
	-it barc_dev_u26

stop:
	docker stop barc_box_u26  || true

container_rm :
	docker rm barc_box_u26 || true
