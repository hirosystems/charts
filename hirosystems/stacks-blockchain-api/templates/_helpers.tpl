{{/*
Return the name of the Stacks-Blockchain API Event Replay image name used for the download and replay init containers
*/}}
{{- define "stacksBlockchainApiEventReplay.image" -}}
{{ include "common.images.image (dict "imageRoot" .Values.apiWriter.replayEvents.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Stacks-Blockchain API image name
*/}}
{{- define "stacksBlockchainApi.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.apiWriter.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper image name (for the init container volume-permissions image)
*/}}
{{- define "stacksBlockchainApi.volumePermissions.image" -}}
{{- include "common.images.image" ( dict "imageRoot" .Values.apiWriter.volumePermissions.image "global" .Values.global ) -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "stacksBlockchainApi.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.apiWriter.image .Values.apiReader.image .Values.apiRosettaReader.image .Values.apiWriter.volumePermissions.image) "global" .Values.global) -}}
{{- end -}}

{{/*
The API service port for the Stacks Blockchain API writer
*/}}
{{- define "stacksBlockchainApi.apiWriter.service.ports.api" -}}
{{ default "20443" .Values.apiWriter.service.ports.api }}
{{- end -}}

{{/*
The API service port for the Stacks Blockchain API reader
*/}}
{{- define "stacksBlockchainApi.apiReader.service.ports.api" -}}
{{ default "20443" .Values.apiReader.service.ports.api }}
{{- end -}}

{{/*
The API service port for the Stacks Blockchain API Rosetta reader
*/}}
{{- define "stacksBlockchainApi.apiRosettaReader.service.ports.api" -}}
{{ default "20443" .Values.apiRosettaReader.service.ports.api }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "stacksBlockchainApi.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return true if cert-manager required annotations for TLS signed certificates are set in the Ingress annotations
Ref: https://cert-manager.io/docs/usage/ingress/#supported-annotations
*/}}
{{- define "stacksBlockchainApi.ingress.certManagerRequest" -}}
{{ if or (hasKey . "cert-manager.io/cluster-issuer") (hasKey . "cert-manager.io/issuer") }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a secret object for the CDN should be created
*/}}
{{- define "stacksBlockchainApi.cdn.createSecret" -}}
{{- if and (not .Values.cdn.existingSecret) (.Values.cdn.enabled) -}}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return name of the CDN secret
*/}}
{{- define "stacksBlockchainApi.cdn.secretName" -}}
{{ default (include "common.names.fullname" .) .Values.cdn.existingSecret }}
{{- end -}}

{{/*
Return name of the Postgres user
*/}}
{{- define "stacksBlockchainApi.postgresql.username" -}}
{{ default "postgres" (include "postgresql.username" .Subcharts.postgresql) }}
{{- end -}}


{{/*
Compile all warnings into a single message.
*/}}
{{- define "stacksBlockchainApi.validateValues" -}}
{{- $messages := list -}}
{{- $messages := append $messages (include "stacksBlockchainApi.validateValues.apiEnabled" .) -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}

{{- if $message -}}
{{-   printf "\nVALUES VALIDATION:\n%s" $message -}}
{{- end -}}
{{- end -}}

{{/*
Validate values of Stacks Blockchain API - An API must be enabled
*/}}
{{- define "stacksBlockchainApi.validateValues.apiEnabled" -}}
{{- if not (or .Values.apiWriter.enabled .Values.apiReader.enabled) }}
stacksBlockchainApi: apiWriter.enabled, apiReader.enabled
    An api-writer, api-reader, or both must be enabled
{{- end -}}
{{- end -}}
