{{/*
Expand the name of the chart.
*/}}
{{- define "geoServer.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "geoServer.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "geoServer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "geoServer.labels" -}}
helm.sh/chart: {{ include "geoServer.chart" . }}
{{ include "geoServer.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "geoServer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "geoServer.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "geoServer.serviceAccountName" -}}
{{- if .Values.geoServer.serviceAccount.enabled }}
{{- default (include "geoServer.name" .) .Values.geoServer.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "edp.hostnameSuffix" -}}
{{- printf "%s-%s.%s" .Values.cdPipelineName .Values.cdPipelineStageName .Values.dnsWildcard }}
{{- end }}

{{- define "geoServer.hostname" -}}
{{- $hostname := printf "%s-%s" .Release.Name .Release.Namespace }}
{{- printf "%s.%s" $hostname .Values.dnsWildcard }}
{{- end }}

{{- define "officer-portal.hostname" -}}
{{- $root := .root }}
{{- $portal := .portal }}
{{- printf "%s-%s" "officer-portal" (include "edp.hostnameSuffix" $root) }}
{{- end }}

{{- define "geoServer.url" -}}
{{- printf "%s%s" "https://" (include "geoServer.hostname" .) }}
{{- end }}

{{- define "geoServer.volume.name" -}}
{{- printf "%s-%s" (include "geoServer.name" . ) "data" }}
{{- end }}