#!/bin/sh
set -e
#Добавляем репозиторий
helm repo add stable https://kubernetes-charts.storage.googleapis.com
#Обновляем
helm repo update
#Создаем namespace
kubectl create namespace monitoring
#Устанавливаем helm c именем my-prometheus
helm install my-prometheus stable/prometheus -n monitoring
