{{- define "hello-eks.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}

{{- define "hello-eks.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "hello-eks.labels" -}}
app.kubernetes.io/name: {{ include "hello-eks.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.Version }}
app.kubernetes.io/managed-by: Helm
{{- end }}
