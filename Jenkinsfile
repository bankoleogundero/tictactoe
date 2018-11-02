#!/usr/bin/groovy

def versionPrefix = ""
try {
  versionPrefix = VERSION_PREFIX
} catch (Throwable e) {
  versionPrefix = "1.0"
}

def canaryVersion = "${versionPrefix}.${env.BUILD_NUMBER}"

def organisation = ""
try {
  organisation = ORGANISATION
} catch (Throwable e) {
  organisation = "octopuslabs"
}

def envStage = "${env.JOB_NAME}-dev"
def envProd = "${env.JOB_NAME}-prod"

node ('kubernetes'){

  git 'https://github.com/bankoleogundero/tictactoe'

  kubernetes.pod('buildpod').withImage('bankoleogundero/tictactoe')
      .withPrivileged(true)
      .withHostPathMount('/var/run/docker.sock','/var/run/docker.sock')
      .withEnvVar('DOCKER_CONFIG','/home/jenkins/.docker/')
      .withSecret('jenkins-docker-cfg','/home/jenkins/.docker')
      .withServiceAccount('jenkins')
      .inside {

        stage 'canary release'

          def clusterImageName = "${env.DOCKER_REGISTRY_SERVICE_HOST}:${env.DOCKER_REGISTRY_SERVICE_PORT}/${organisation}/${env.JOB_NAME}:${versionPrefix}"
          def dockerhubImageName = "docker.io/${organisation}/${env.JOB_NAME}:${versionPrefix}"


          if (!fileExists ('Dockerfile')) {
            writeFile file: 'Dockerfile', text: 'FROM django:onbuild'
          }
          sh "docker build --rm -t ${clusterImageName} ."
         // sh "docker push ${clusterImageName}"

          def rc = getKubernetesJson {
            port = 8000
            label = 'django'
            version = versionPrefix
            imageName = clusterImageName
          }

          sh 'echo "commit:" `git rev-parse HEAD` >> git.yml && echo "branch:" `git rev-parse --abbrev-ref HEAD` >> git.yml'

        stage 'Rolling upgrade Staging'
          kubernetesApply(file: rc, environment: envStage)

        approve{
          room = null
          version = canaryVersion
          console = fabric8Console
          environment = envStage
        }

        // stage 'promote'
        //   sh "docker tag -f ${clusterImageName} ${dockerhubImageName}"
        //   sh "docker push -f ${dockerhubImageName}"

        stage 'Rolling upgrade Production'
          kubernetesApply(file: rc, environment: envProd)

  }
}