#!/bin/sh

ENV=$1
VERSION=$2
USER=$3
PASSWORD=$4

usage() {
	echo 'usage: ./docker/build.sh <dev|prod> [version] [user] [password]' >&2
	echo 'e.g.:  ./docker/build.sh prod latest user password' >&2
	exit 2
}

# argument parsing
[ $# -lt 1 ] && usage
case "$ENV" in
dev) ;; # we can ignore extra arguments
prod) [ $# -ne 4 ] && usage ;;
*) usage
esac

# use phz prefix for dev images and phzfi for prod images
if [ "$ENV" = 'dev' ]; then
	IMAGE=phz/debian-php-fpm:dev
else # prod
	IMAGE=phzfi/debian-php-fpm:$VERSION
	LATEST=phzfi/debian-php-fpm:latest
fi

echo "Building ${ENV} ${IMAGE}"
#docker build --platform linux/386 -t "$IMAGE" -f Dockerfile . --no-cache
docker build -t "$IMAGE" -f Dockerfile . --no-cache || exit $?

if [ "$ENV" = 'prod' ]; then
	docker login -u "$USER" -p "$PASSWORD"
	docker tag "$IMAGE" "$IMAGE"
	docker tag "$IMAGE" "$LATEST"
	docker push "$IMAGE"
	docker push "$LATEST"
fi
