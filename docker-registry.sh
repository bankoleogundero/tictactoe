# This will be run through Octopus Deploy and the values in the #{} will be replaced
kubectl create secret docker-secret -n tictactoe #{DOCKER_REGISTRY_URL} \
--docker-server=#{DOCKER_SERVER} \
--docker-username=#{DOCKER_REGISTRY_USERNAME} \
--docker-password=#{DOCKER_REGISTRY_PASSWORD} \
--docker-email=#{DOCKER_REGISTRY_EMAIL}
