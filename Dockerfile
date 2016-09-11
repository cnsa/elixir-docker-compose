FROM cnsa/ubuntu-iconv:0.9.18

ARG VERSION

# COPY APP

RUN mkdir /app
WORKDIR /app

COPY ./rel/some_app/releases/$VERSION/some_app.tar.gz /app/some_app.tar.gz
RUN tar -zxvf some_app.tar.gz > /dev/null 2>&1

WORKDIR /app/releases/$VERSION

# RUN

EXPOSE 4000

ENTRYPOINT ["./some_app.sh"]
CMD ["foreground"]
