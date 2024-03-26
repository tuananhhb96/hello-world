
PROJECT_NAME="$1"  # Project name.
ENV_DEPLOY=$2  # develop | staging | production
VERSION=$3  # Version of docker servicers

export PROJECT_DIR=$PWD

# Develop here
IMAGE_NAME=$PROJECT_NAME
REPO_SERVER=harbor.signetcenter.systems/uat-signet
REPO_IMAGE_TAG=$REPO_SERVER/${IMAGE_NAME}:$VERSION

echo " **** Deploy image ${PROJECT_NAME}: This is deploy for BE and FE here ! **** "

if [ $ENV_DEPLOY == "production" ]; then
#   REPO_PROJECT=${REPO_PROJECT_PRO}
  PROJECT_SERVER_DIR=$PROJECT_DIR/server/product
elif [ $ENV_DEPLOY == "staging" ]; then
#   REPO_PROJECT=${REPO_PROJECT_STG}
   PROJECT_SERVER_DIR=$PROJECT_DIR/server/staging
elif [ $ENV_DEPLOY == "develop" ]; then
#   REPO_PROJECT=${REPO_PROJECT_DEV}
  PROJECT_SERVER_DIR=$PROJECT_DIR/server/develop
fi

if [ "$ENV_DEPLOY" ]; then
  cd $PROJECT_SERVER_DIR 
fi

for file in */*.yml; do
    if [[ "$OSTYPE" == "darwin"* ]]; then
      sed -i "" "s|\(image\).*\($IMAGE_NAME\:\).*|image: $REPO_IMAGE_TAG|g" $file
      echo "Change Success"
    else
       sed -i "s|\(image\).*\($IMAGE_NAME\:\).*|image: $REPO_IMAGE_TAG|g" $eachfile  
    fi
done;