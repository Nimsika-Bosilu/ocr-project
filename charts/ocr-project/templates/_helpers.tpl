{{/*
Common chart name.
*/}}
{{- define "ocr-project.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common full name.
*/}}
{{- define "ocr-project.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Service account name.
*/}}
{{- define "ocr-project.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ocr-project.fullname" .) .Values.serviceAccount.name }}
{{- else }}
default
{{- end }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "ocr-project.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/name: {{ include "ocr-project.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}