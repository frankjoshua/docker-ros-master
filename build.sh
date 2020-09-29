docker buildx version
if [[ $? -ne 0 ]]; then
echo "Docker must have experimental features enabled"
exit 1
fi
if [[ $# -lt 1 ]]; then
echo "Usage: build.sh CONTAINER_NAME [--push]"
exit 1
fi
BUILDER=$(docker buildx create --use)
docker buildx build -t $1 --platform linux/arm/v7,linux/arm64/v8,linux/amd64 . $2
docker buildx rm $BUILDER