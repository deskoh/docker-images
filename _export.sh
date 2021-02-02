OUT=_load_images.sh
echo '#!/bin/sh' > $OUT

# nginx

docker build nginx -t ${PRIVATE_REGISTRY}nginx
docker save ${PRIVATE_REGISTRY}nginx -o ubi-nginx.tar
docker image rm ${PRIVATE_REGISTRY}nginx

echo docker load -i ubi-nginx.tar >> $OUT
echo docker push ${PRIVATE_REGISTRY}nginx >> $OUT
echo docker image rm ${PRIVATE_REGISTRY}nginx >> $OUT

# node14

docker build node -t ${PRIVATE_REGISTRY}node:14
docker save ${PRIVATE_REGISTRY}node:14 -o ubi-node-14.tar
docker image rm ${PRIVATE_REGISTRY}node:14

echo docker load -i ubi-node-14.tar >> $OUT
echo docker push ${PRIVATE_REGISTRY}node:14 >> $OUT
echo docker image rm ${PRIVATE_REGISTRY}node:14 >> $OUT

# node12

docker build --build-arg NODE_VERSION=12 node -t ${PRIVATE_REGISTRY}node:12
docker save ${PRIVATE_REGISTRY}node:12 -o ubi-node-12.tar
docker image rm ${PRIVATE_REGISTRY}node:12

echo docker load -i ubi-node-12.tar >> $OUT
echo docker push ${PRIVATE_REGISTRY}node:12 >> $OUT
echo docker image rm ${PRIVATE_REGISTRY}node:12 >> $OUT
