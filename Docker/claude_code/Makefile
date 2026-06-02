TOP=../..

all : run

build_homedir:
	rm -rf homedir
	mkdir -p homedir
	cp .emacs homedir/
	cp $(TOP)/.git-completion.bash homedir/
	cp $(TOP)/.profile homedir/
	cp $(TOP)/.bashrc homedir/
	cp -r ~/.aws homedir/

build: build_homedir
	docker build -t claude_box_u26 .

run:
	docker run --name claude_info_u26 \
	   --network host \
	   --volume /tmp:/tmp \
	   --mount source=rnd,destination=/rnd,readonly \
	-it claude_box_u26

stop:
	docker stop claude_info_u26  || true
	docker rm claude_info_u26 || true
