TOP=../..

all : barc_dev

barc_dev: build_homedir
	docker build -t barc_dev_u22 .
	docker run --name barc_box_u22 --privileged \
	   --volume /tmp:/tmp \
	   --volume /Users/orodeh/U/Reference:/root/Reference:ro \
	   --volume /Users/orodeh/U/Data:/root/Data:ro \
	   --volume /Users/orodeh/U/STAR:/root/STAR:rw \
           --volume /var/run/docker.sock:/var/run/docker.sock \
	-it barc_dev_u22

build_homedir:
	rm -rf homedir
	mkdir -p homedir
	cp $(TOP)/.emacs homedir/
	cp -r $(TOP)/.emacs.d homedir/
	cp $(TOP)/.git-completion.bash homedir/
	cp $(TOP)/.profile homedir/
	cp $(TOP)/.bashrc homedir/
	cp  ~/.gitconfig homedir/
	cp  ~/.gitignore_global homedir/
	cp -r ~/.ssh homedir/
	cp -r ~/.aws homedir/

stop:
	docker stop barc_box_u22  || true
	docker rm barc_box_u22 || true
