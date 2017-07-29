# datakart-backend

Bootstrap datakart-backend based on a mu.semte.ch microservices environment in three easy steps.

### Boot up the system

Boot your microservices-enabled system using docker-compose.

    cd /path/to/mu-project
    rm -rf data/db*; rm -rf data/datakart-raw-tracking/*; docker-rm-containers; docker-compose stop; docker-compose rm -f; docker-compose up

You can shut down using `docker-compose stop` and remove everything using `docker-compose rm`.

### query data

traking-session will keep track of raw-data id

/tracking-sessions

raw data e.g ->
/raw-tracking-sessions/0806976e-19cf-4bd6-9c3a-2839bc96ae22/data-points?start=21:20:51.800559&end=21:20:51.972729
