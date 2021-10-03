FROM ghcr.io/phillmv/arquivo:latest
ENV RUBYGEMS_VERSION=2.7.0
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

LABEL "com.github.actions.name"="MAWL"
LABEL "com.github.actions.description"="MAWL: Make a weblog! MAWL converts repositories (or repo subfolders) containing markdown or html files, etc, into fully fledged blog-like static sites. It then pushes that site to any given repo+branch, so that it may be hosted as a GitHub Page."
LABEL "com.github.actions.icon"="book-open"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/phillmv/mawl"

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
