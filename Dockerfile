FROM ruby:alpine3.20 as builder

ENV ROOT="/app"
ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

WORKDIR ${ROOT}

RUN apk update && \
    apk add --no-cache \
        gcc \
        g++ \
        libc-dev \
        libxml2-dev \
        linux-headers \
        make \
        postgresql-client \
        postgresql-dev \
        tzdata && \
    apk add --virtual build-packs --no-cache \
        build-base \
        curl-dev

COPY Gemfile ${ROOT}
COPY Gemfile.lock ${ROOT}

RUN bundle install
RUN apk del build-packs

# -------------------------------------------
FROM ruby:alpine3.20

ENV ROOT="/app"
ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

RUN apk update && \
    apk add \
        postgresql-client \
        tzdata

WORKDIR ${ROOT}

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY . ${ROOT}
EXPOSE 4567
CMD ["ruby", "main.rb"]
