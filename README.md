# Techincal Test of TicTacToe in Django

A django project of a game called tictactoe.
1) The application is written in Python using the Django framework
2) There are mysql and redis yml files that can be deployed into k8s cluster. The django app uses sqlite db for now
3) There is a Dockerfile as well as a docker-compose file to build the app locally on your machine
4) The application autoscales based on CPU usage (in the yml file)
5) Secrets are also based in the yaml files (you can find these in the helm folder)
6) Jenkins configuration for building the app is included
7) Github: https://github.com/bankoleogundero/tictactoe/
