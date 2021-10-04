FROM ghcr.io/phillmv/arquivo:latest
ENV RUBYGEMS_VERSION=2.7.0
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

LABEL "com.github.actions.name"="mawl"
LABEL "com.github.actions.description"="mawl: Make a Weblog! mawl converts repos w/markdown files into full blog-like static sites for hosting on GH Pages."
LABEL "com.github.actions.icon"="book-open"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/phillmv/mawl"

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
