FROM cnsa/elixir

# COMPILE DEPS

# RUN apt-get update -qq
# RUN apt-get install -qqy imagemagick libtool
#
# WORKDIR /tmp
#
# RUN wget -q https://gist.githubusercontent.com/merqlove/eda0bd9511fce0d319e6efb152f8c68d/raw/aab4e897a6233b38c4252a9ca8db2641aad50874/iconv_install_ubuntu14.sh && \
#   chmod +x iconv_install_ubuntu14.sh && \
#   ./iconv_install_ubuntu14.sh

# COPY APP

RUN mkdir /app

ENV VERSION "0.0.0"

COPY . /app

RUN mv /app/entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# COMPILE APP

WORKDIR /app

RUN MIX_ENV=prod MIX_QUIET=1 mix do deps.get, compile, release

# RUN

EXPOSE 4000

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["foreground"]
