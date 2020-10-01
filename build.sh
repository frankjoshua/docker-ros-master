# Check that buildx is enabled
docker buildx version
if [[ $? -ne 0 ]]; then
echo "Docker must have experimental features enabled"
exit 1
fi
# Check for container parameter
if [[ $# -lt 1 ]]; then
echo "Usage: build.sh CONTAINER_NAME [--push]"
exit 1
fi
# Setup qemu for multiplatform builds
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
# Create builder for docker
BUILDER=$(docker buildx create --use)
# Build container on all achitectures in parallel and push to Docker Hub
docker buildx build -t $1 --platform linux/arm/v7,linux/arm64/v8,linux/amd64 . $2
# Clean up and return error code for CI system if needed
ERROR_CODE=$?
docker buildx rm $BUILDER
if [[ $ERROR_CODE -ne 0 ]]; then
 exit $ERROR_CODE
fi