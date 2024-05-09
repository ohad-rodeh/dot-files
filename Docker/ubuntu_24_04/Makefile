TOP=../..

all : run

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

build: build_homedir
	docker build -t barc_dev_u24 .

run:
	docker run --name barc_box_u24 \
	   --privileged \
	   --volume /tmp:/tmp \
	   --volume /Users/orodeh/U/Reference:/Reference:ro \
	   --volume /Users/orodeh/U/Data:/Data:ro \
	   --volume /Users/orodeh/U/RNA:/RNA \
           --volume /var/run/docker.sock:/var/run/docker.sock \
	   --mount source=rnd,destination=/rnd \
	-it barc_dev_u24


stop:
	docker stop barc_box_u24  || true
	docker rm barc_box_u24 || true
