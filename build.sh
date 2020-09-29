BUILDER=$(docker buildx create --use)
docker buildx build -t $1 --platform linux/arm/v7,linux/arm64/v8,linux/amd64 . $2
docker buildx rm $BUILDER