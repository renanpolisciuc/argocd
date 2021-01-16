kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-notifications/stable/manifests/install.yaml

kubectl apply -n argocd -f - << EOF
apiVersion: v1
kind: Secret
metadata:
  name: argocd-notifications-secret
stringData:
  notifiers.yaml: |
    grafana:
      apiUrl: <URL>
      apiKey: <TOKEN>
EOF

kubectl apply -n argocd -f - << EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-notifications-cm
data:
  config.yaml: |
    triggers:
      - name: on-sync-succeeded
        enabled: true
EOF


kubectl patch app grafana -n argocd -p '{"metadata": {"annotations": {"recipients.argocd-notifications.argoproj.io":"grafana:argocd"}}}' --type merge
