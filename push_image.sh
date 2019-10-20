for tag in ${tags//,/ }
do
  docker tag $DOCKER_REPO:local $DOCKER_REPO:$tag
  docker push $DOCKER_REPO:$tag
done
