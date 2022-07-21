FROM golang:1.16-buster

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY *.go ./

RUN go build -o docker-gs-ping-roach

COPY db/ db
COPY migrate_db.sh ./
RUN ln -sf /app/migrate_db.sh /usr/bin/migrate_db.sh

ADD https://github.com/golang-migrate/migrate/releases/download/v4.15.2/migrate.linux-amd64.tar.gz ./
RUN tar xvfz migrate.linux-amd64.tar.gz

ADD https://www.postgresql.org/media/keys/ACCC4CF8.asc ./
RUN apt-key add ACCC4CF8.asc

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" > /etc/apt/sources.list.d/pgdg.list


RUN DEBIAN=noninteractive apt-get update && apt-get install -y postgresql-client-13

EXPOSE 8080

CMD ["/app/docker-gs-ping-roach"]
