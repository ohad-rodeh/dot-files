TOP=../..

all : barc_dev

barc_dev: build_homedir
	docker build -t barc_dev_u20 .
	docker run --name barc_box_u20 --privileged \
	   --volume /tmp:/tmp \
	   --volume /Users/orodeh/U/Reference:/root/Reference:ro \
	   --volume /Users/orodeh/U/Data:/root/Data:ro \
	-it barc_dev_u20

build_homedir:
	rm -rf homedir
	mkdir -p homedir
	cp $(TOP)/.emacs homedir/
	cp -r $(TOP)/.emacs.d homedir/
	cp $(TOP)/.git-completion.bash homedir/
	cp $(TOP)/.git-prompt.sh homedir/
	cp  ~/.gitconfig homedir/
	cp  ~/.gitignore_global homedir/
	cp -r ~/.ssh homedir/
	cp -r ~/.aws homedir/

stop:
	docker stop barc_box_u20  || true
	docker rm barc_box_u20 || true
