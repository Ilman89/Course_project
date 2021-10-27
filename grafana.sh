#!/bin/sh
set -e
#Добавляем репозиторий
helm repo add bitnami https://charts.bitnami.com/bitnami
#Устанавливаем helm c именем my-
helm install my-grafana bitnami/grafana -n monitoring --set=persistence.enabled=false

