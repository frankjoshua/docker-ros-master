# Check that buildx is enabled
docker buildx version > /dev/null
if [[ $? -ne 0 ]]; then
    echo "Docker must have experimental features enabled"
    exit 1
fi
ARCHITECTURE="linux/arm/v7,linux/arm64/v8,linux/amd64"
usage() { 
    echo "Usage: $0 -t <DOCKER_TAG> [-a <ARCHITECTURE>] [-p Push] [-l Local build]"
    echo "Default architecture: linux/arm/v7,linux/arm64/v8,linux/amd64"
    exit 1 
}
while getopts ":a:t:pql" o; do
    case "${o}" in
        t)
            TAG="${OPTARG}"
            ;;
        p)
            PUSH="--push"
            ;;
        q)
            QUIET="2> /dev/null"
            ;;
        a)
            ARCHITECTURE="${OPTARG}"
            ;;
        l)
            LOCAL="true"
            ;;
        :)  
            echo "ERROR: Option -$OPTARG requires an argument"
            usage
            ;;
        \?)
            echo "ERROR: Invalid option -$OPTARG"
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [[ "${TAG}" -eq "" ]]; then
    usage
    exit 1
fi

if [[ "${LOCAL}" -ne "" ]]; then
  # Create builder for docker
  BUILDER=$(docker buildx create --use)
  # Setup qemu for multiplatform builds
  docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
fi
# Build container on all achitectures in parallel and push to Docker Hub
eval "docker buildx build $PUSH -t $TAG --platform $ARCHITECTURE . $QUIET"
# Clean up and return error code for CI system if needed
ERROR_CODE=$?
if [[ "${LOCAL}" -ne "" ]]; then
  docker buildx rm $BUILDER
fi
if [[ $ERROR_CODE -ne 0 ]]; then
 exit $ERROR_CODE
fi