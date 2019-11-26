for tag in ${tags//,/ }
do
  docker tag $DOCKER_REPO:$name $DOCKER_REPO:$tag
  docker push $DOCKER_REPO:$tag
done
