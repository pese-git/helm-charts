{{- define "mlflow.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "mlflow.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := include "mlflow.name" . }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "mlflow.redirectURI" -}}
{{- if .Values.oidc.redirectURI }}
{{- .Values.oidc.redirectURI }}
{{- else }}
{{- if .Values.ingress.enabled }}
{{- if .Values.ingress.tls }}
{{- printf "https://%s/oauth/callback" .Values.ingress.host }}
{{- else }}
{{- printf "http://%s/oauth/callback" .Values.ingress.host }}
{{- end }}
{{- else }}
{{- printf "http://localhost:8080/oauth/callback" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "mlflow.databaseURI" -}}
{{- printf "postgresql://%s:%s@%s:%s/%s" .Values.database.username .Values.database.password .Values.database.host (toString .Values.database.port) .Values.database.name }}
{{- end }}
