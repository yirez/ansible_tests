#!/bin/sh
set -e
set -o pipefail


echo "**************************************"
echo "Creates a grafana dashboard"
echo "**************************************"
echo ""


# Exit script after printing help
helpFunction()
{
   echo ""
   echo "Usage: $0 grafana_url->ip:port"
   exit 1
}

 
# Begin script in case all parameters are correct
echo "grafana_url: $1"

grafana_url=$1

# Print helpFunction in case parameters are empty
if [ -z "$grafana_url" ]
then
   echo "Missing parameters";
   helpFunction
fi



echo " "
echo "Deploy grafana dashboard"
echo "**************************************"

#TODO- get Authz from some other place
curl -i \
-H "Accept: application/json" \
-H "Authorization: Bearer eyJr...pZCI6MX0=" \
-H "Content-Type: application/json" \
-X POST --data '{ "dashboard": {
    "id": null,
    "uid": null,
    "title": "dashboard ty",
    "timezone": "browser",
    "schemaVersion": 16,
    "version": 0,
    "refresh": "5s"
  },
  "annotations": {
    "list": [
      {
        "builtIn": 1,
        "datasource": "-- Grafana --",
        "enable": true,
        "hide": true,
        "iconColor": "rgba(0, 211, 255, 1)",
        "name": "Annotations & Alerts",
        "type": "dashboard"
      }
    ]
  },
  "description": "Monitors Kubernetes cluster using Prometheus. Shows overall cluster CPU / Memory / Filesystem usage as well as individual pod, containers, systemd services statistics. Uses cAdvisor metrics only.",
  "editable": true,
  "gnetId": 315,
  "graphTooltip": 0,
  "id": 1,
  "iteration": 1622133002304,
  "links": [],
  "panels": [
    {
      "collapsed": false,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 0
      },
      "id": 33,
      "panels": [],
      "title": "Network I/O pressure",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "prometheus",
      "decimals": 2,
      "editable": true,
      "error": false,
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "grid": {},
      "gridPos": {
        "h": 6,
        "w": 24,
        "x": 0,
        "y": 1
      },
      "height": "200px",
      "hiddenSeries": false,
      "id": 32,
      "isNew": true,
      "legend": {
        "alignAsTable": false,
        "avg": true,
        "current": true,
        "max": false,
        "min": false,
        "rightSide": false,
        "show": false,
        "sideWidth": 200,
        "sort": "current",
        "sortDesc": true,
        "total": false,
        "values": true
      },
      "lines": true,
      "linewidth": 2,
      "links": [],
      "nullPointMode": "connected",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "expr": "sum (rate (container_network_receive_bytes_total{kubernetes_io_hostname=~\"^$Node$\"}[1m]))",
          "interval": "10s",
          "intervalFactor": 1,
          "legendFormat": "Received",
          "metric": "network",
          "refId": "A",
          "step": 10
        },
        {
          "expr": "- sum (rate (container_network_transmit_bytes_total{kubernetes_io_hostname=~\"^$Node$\"}[1m]))",
          "interval": "10s",
          "intervalFactor": 1,
          "legendFormat": "Sent",
          "metric": "network",
          "refId": "B",
          "step": 10
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Network I/O pressure",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "cumulative"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "Bps",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "Bps",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": false
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "collapsed": false,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 7
      },
      "id": 34,
      "panels": [],
      "title": "Total usage",
      "type": "row"
    },
    {
      "cacheTimeout": null,
      "colorBackground": false,
      "colorValue": true,
      "colors": [
        "rgba(50, 172, 45, 0.97)",
        "rgba(237, 129, 40, 0.89)",
        "rgba(245, 54, 54, 0.9)"
      ],
      "datasource": "prometheus",
      "editable": true,
      "error": false,
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "format": "percent",
      "gauge": {
        "maxValue": 100,
        "minValue": 0,
        "show": true,
        "thresholdLabels": false,
        "thresholdMarkers": true
      },
      "gridPos": {
        "h": 5,
        "w": 8,
        "x": 0,
        "y": 8
      },
      "height": "180px",
      "id": 4,
      "interval": null,
      "isNew": true,
      "links": [],
      "mappingType": 1,
      "mappingTypes": [
        {
          "name": "value to text",
          "value": 1
        },
        {
          "name": "range to text",
          "value": 2
        }
      ],
      "maxDataPoints": 100,
      "nullPointMode": "connected",
      "nullText": null,
      "postfix": "",
      "postfixFontSize": "50%",
      "prefix": "",
      "prefixFontSize": "50%",
      "rangeMaps": [
        {
          "from": "null",
          "text": "N/A",
          "to": "null"
        }
      ],
      "sparkline": {
        "fillColor": "rgba(31, 118, 189, 0.18)",
        "full": false,
        "lineColor": "rgb(31, 120, 193)",
        "show": false
      },
      "tableColumn": "",
      "targets": [
        {
          "expr": "sum (container_memory_working_set_bytes{id=\"/\",kubernetes_io_hostname=~\"^$Node$\"}) / sum (machine_memory_bytes{kubernetes_io_hostname=~\"^$Node$\"}) * 100",
          "interval": "10s",
          "intervalFactor": 1,
          "refId": "A",
          "step": 10
        }
      ],
      "thresholds": "65, 90",
      "title": "Cluster memory usage",
      "type": "singlestat",
      "valueFontSize": "80%",
      "valueMaps": [
        {
          "op": "=",
          "text": "N/A",
          "value": "null"
        }
      ],
      "valueName": "current"
    },
    {
      "cacheTimeout": null,
      "colorBackground": false,
      "colorValue": true,
      "colors": [
        "rgba(50, 172, 45, 0.97)",
        "rgba(237, 129, 40, 0.89)",
        "rgba(245, 54, 54, 0.9)"
      ],
      "datasource": "prometheus",
      "decimals": 2,
      "editable": true,
      "error": false,
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "format": "percent",
      "gauge": {
        "maxValue": 100,
        "minValue": 0,
        "show": true,
        "thresholdLabels": false,
        "thresholdMarkers": true
      },
      "gridPos": {
        "h": 5,
        "w": 8,
        "x": 8,
        "y": 8
      },
      "height": "180px",
      "id": 6,
      "interval": null,
      "isNew": true,
      "links": [],
      "mappingType": 1,
      "mappingTypes": [
        {
          "name": "value to text",
          "value": 1
        },
        {
          "name": "range to text",
          "value": 2
        }
      ],
      "maxDataPoints": 100,
      "nullPointMode": "connected",
      "nullText": null,
      "postfix": "",
      "postfixFontSize": "50%",
      "prefix": "",
      "prefixFontSize": "50%",
      "rangeMaps": [
        {
          "from": "null",
          "text": "N/A",
          "to": "null"
        }
      ],
      "sparkline": {
        "fillColor": "rgba(31, 118, 189, 0.18)",
        "full": false,
        "lineColor": "rgb(31, 120, 193)",
        "show": false
      },
      "tableColumn": "",
      "targets": [
        {
          "expr": "sum (rate (container_cpu_usage_seconds_total{id=\"/\",kubernetes_io_hostname=~\"^$Node$\"}[1m])) / sum (machine_cpu_cores{kubernetes_io_hostname=~\"^$Node$\"}) * 100",
          "interval": "10s",
          "intervalFactor": 1,
          "refId": "A",
          "step": 10
        }
      ],
      "thresholds": "65, 90",
      "title": "Cluster CPU usage (1m avg)",
      "type": "singlestat",
      "valueFontSize": "80%",
      "valueMaps": [
        {
          "op": "=",
          "text": "N/A",
          "value": "null"
        }
      ],
      "valueName": "current"
    },
    {
      "cacheTimeout": null,
      "colorBackground": false,
      "colorValue": true,
      "colors": [
        "rgba(50, 172, 45, 0.97)",
        "rgba(237, 129, 40, 0.89)",
        "rgba(245, 54, 54, 0.9)"
      ],
      "datasource": "prometheus",
      "decimals": 2,
      "editable": true,
      "error": false,
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "format": "percent",
      "gauge": {
        "maxValue": 100,
        "minValue": 0,
        "show": true,
        "thresholdLabels": false,
        "thresholdMarkers": true
      },
      "gridPos": {
        "h": 5,
        "w": 8,
        "x": 16,
        "y": 8
      },
      "height": "180px",
      "id": 7,
      "interval": null,
      "isNew": true,
      "links": [],
      "mappingType": 1,
      "mappingTypes": [
        {
          "name": "value to text",
          "value": 1
        },
        {
          "name": "range to text",
          "value": 2
        }
      ],
      "maxDataPoints": 100,
      "nullPointMode": "connected",
      "nullText": null,
      "postfix": "",
      "postfixFontSize": "50%",
      "prefix": "",
      "prefixFontSize": "50%",
      "rangeMaps": [
        {
          "from": "null",
          "text": "N/A",
          "to": "null"
        }
      ],
      "sparkline": {
        "fillColor": "rgba(31, 118, 189, 0.18)",
        "full": false,
        "lineColor": "rgb(31, 120, 193)",
        "show": false
      },
      "tableColumn": "",
      "targets": [
        {
          "expr": "sum (container_fs_usage_bytes{device=~\"^/dev/[sv]d[a-z][1-9]$\",id=\"/\",kubernetes_io_hostname=~\"^$Node$\"}) / sum (container_fs_limit_bytes{device=~\"^/dev/[sv]d[a-z][1-9]$\",id=\"/\",kubernetes_io_hostname=~\"^$Node$\"}) * 100",
          "interval": "10s",
          "intervalFactor": 1,
          "legendFormat": "",
          "metric": "",
          "refId": "A",
          "step": 10
        }
      ],
      "thresholds": "65, 90",
      "title": "Cluster filesystem usage",
      "type": "singlestat",
      "valueFontSize": "80%",
      "valueMaps": [
        {
          "op": "=",
          "text": "N/A",
          "value": "null"
        }
      ],
      "valueName": "current"
    },
    {
      "cacheTimeout": null,
      "colorBackground": false,
      "colorValue": false,
      "colors": [
        "rgba(50, 172, 45, 0.97)",
        "rgba(237, 129, 40, 0.89)",
        "rgba(245, 54, 54, 0.9)"
      ],
      "datasource": "prometheus",
      "decimals": 2,
      "editable": true,
      "error": false,
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "format": "bytes",
      "gauge": {
        "maxValue": 100,
        "minValue": 0,
        "show": false,
        "thresholdLabels": false,
        "thresholdMarkers": true
      },
      "gridPos": {
        "h": 3,
        "w": 4,
        "x": 0,
        "y": 13
      },
      "height": "1px",
      "id": 9,
      "interval": null,
      "isNew": true,
      "links": [],
      "mappingType": 1,
      "mappingTypes": [
        {
          "name": "value to text",
          "value": 1
        },
        {
          "name": "range to text",
          "value": 2
        }
      ],
      "maxDataPoints": 100,
      "nullPointMode": "connected",
      "nullText": null,
      "postfix": "",
      "postfixFontSize": "20%",
      "prefix": "",
      "prefixFontSize": "20%",
      "rangeMaps": [
        {
          "from": "null",
          "text": "N/A",
          "to": "null"
        }
      ],
      "sparkline": {
        "fillColor": "rgba(31, 118, 189, 0.18)",
        "full": false,
        "lineColor": "rgb(31, 120, 193)",
        "show": false
      },
      "tableColumn": "",
      "targets": [
        {
          "expr": "sum (container_memory_working_set_bytes{id=\"/\",kubernetes_io_hostname=~\"^$Node$\"})",
          "interval": "10s",
          "intervalFactor": 1,
          "refId": "A",
          "step": 10
        }
      ],
      "thresholds": "",
      "title": "Used",
      "type": "singlestat",
      "valueFontSize": "50%",
      "valueMaps": [
        {
          "op": "=",
          "text": "N/A",
          "value": "null"
        }
      ],
      "valueName": "current"
    },
    {
      "cacheTimeout": null,
      "colorBackground": false,
      "colorValue": false,
      "colors": [
        "rgba(50, 172, 45, 0.97)",
        "rgba(237, 129, 40, 0.89)",
        "rgba(245, 54, 54, 0.9)"
      ],
      "datasource": "prometheus",
      "decimals": 2,
      "editable": true,
      "error": false,
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "format": "bytes",
      "gauge": {
        "maxValue": 100,
        "minValue": 0,
        "show": false,
        "thresholdLabels": false,
        "thresholdMarkers": true
      },
      "gridPos": {
        "h": 3,
        "w": 4,
        "x": 4,
        "y": 13
      },
      "height": "1px",
      "id": 10,
      "interval": null,
      "isNew": true,
      "links": [],
      "mappingType": 1,
      "mappingTypes": [
        {
          "name": "value to text",
          "value": 1
        },
        {
          "name": "range to text",
          "value": 2
        }
      ],
      "maxDataPoints": 100,
      "nullPointMode": "connected",
      "nullText": null,
      "postfix": "",
      "postfixFontSize": "50%",
      "prefix": "",
      "prefixFontSize": "50%",
      "rangeMaps": [
        {
          "from": "null",
          "text": "N/A",
          "to": "null"
        }
      ],
      "sparkline": {
        "fillColor": "rgba(31, 118, 189, 0.18)",
        "full": false,
        "lineColor": "rgb(31, 120, 193)",
        "show": false
      },
      "tableColumn": "",
      "targets": [
        {
          "expr": "sum (machine_memory_bytes{kubernetes_io_hostname=~\"^$Node$\"})",
          "interval": "10s",
          "intervalFactor": 1,
          "refId": "A",
          "step": 10
        }
      ],
      "thresholds": "",
      "title": "Total",
      "type": "singlestat",
      "valueFontSize": "50%",
      "valueMaps": [
        {
          "op": "=",
          "text": "N/A",
          "value": "null"
        }
      ],
      "valueName": "current"
    },
    {
      "cacheTimeout": null,
      "colorBackground": false,
      "colorValue": false,
      "colors": [
        "rgba(50, 172, 45, 0.97)",
        "rgba(237, 129, 40, 0.89)",
        "rgba(245, 54, 54, 0.9)"
      ],
      "datasource": "prometheus",
      "decimals": 2,
      "editable": true,
      "error": false,
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "format": "none",
      "gauge": {
        "maxValue": 100,
        "minValue": 0,
        "show": false,
        "thresholdLabels": false,
        "thresholdMarkers": true
      },
      "gridPos": {
        "h": 3,
        "w": 4,
        "x": 8,
        "y": 13
      },
      "height": "1px",
      "id": 11,
      "interval": null,
      "isNew": true,
      "links": [],
      "mappingType": 1,
      "mappingTypes": [
        {
          "name": "value to text",
          "value": 1
        },
        {
          "name": "range to text",
          "value": 2
        }
      ],
      "maxDataPoints": 100,
      "nullPointMode": "connected",
      "nullText": null,
      "postfix": " cores",
      "postfixFontSize": "30%",
      "prefix": "",
      "prefixFontSize": "50%",
      "rangeMaps": [
        {
          "from": "null",
          "text": "N/A",
          "to": "null"
        }
      ],
      "sparkline": {
        "fillColor": "rgba(31, 118, 189, 0.18)",
        "full": false,
        "lineColor": "rgb(31, 120, 193)",
        "show": false
      },
      "tableColumn": "",
      "targets": [
        {
          "expr": "sum (rate (container_cpu_usage_seconds_total{id=\"/\",kubernetes_io_hostname=~\"^$Node$\"}[1m]))",
          "interval": "10s",
          "intervalFactor": 1,
          "refId": "A",
          "step": 10
        }
      ],
      "thresholds": "",
      "title": "Used",
      "type": "singlestat",
      "valueFontSize": "50%",
      "valueMaps": [
        {
          "op": "=",
          "text": "N/A",
          "value": "null"
        }
      ],
      "valueName": "current"
    },
    {
      "cacheTimeout": null,
      "colorBackground": false,
      "colorValue": false,
      "colors": [
        "rgba(50, 172, 45, 0.97)",
        "rgba(237, 129, 40, 0.89)",
        "rgba(245, 54, 54, 0.9)"
      ],
      "datasource": "prometheus",
      "decimals": 2,
      "editable": true,
      "error": false,
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "format": "none",
      "gauge": {
        "maxValue": 100,
        "minValue": 0,
        "show": false,
        "thresholdLabels": false,
        "thresholdMarkers": true
      },
      "gridPos": {
        "h": 3,
        "w": 4,
        "x": 12,
        "y": 13
      },
      "height": "1px",
      "id": 12,
      "interval": null,
      "isNew": true,
      "links": [],
      "mappingType": 1,
      "mappingTypes": [
        {
          "name": "value to text",
          "value": 1
        },
        {
          "name": "range to text",
          "value": 2
        }
      ],
      "maxDataPoints": 100,
      "nullPointMode": "connected",
      "nullText": null,
      "postfix": " cores",
      "postfixFontSize": "30%",
      "prefix": "",
      "prefixFontSize": "50%",
      "rangeMaps": [
        {
          "from": "null",
          "text": "N/A",
          "to": "null"
        }
      ],
      "sparkline": {
        "fillColor": "rgba(31, 118, 189, 0.18)",
        "full": false,
        "lineColor": "rgb(31, 120, 193)",
        "show": false
      },
      "tableColumn": "",
      "targets": [
        {
          "expr": "sum (machine_cpu_cores{kubernetes_io_hostname=~\"^$Node$\"})",
          "interval": "10s",
          "intervalFactor": 1,
          "refId": "A",
          "step": 10
        }
      ],
      "thresholds": "",
      "title": "Total",
      "type": "singlestat",
      "valueFontSize": "50%",
      "valueMaps": [
        {
          "op": "=",
          "text": "N/A",
          "value": "null"
        }
      ],
      "valueName": "current"
    },
    {
      "cacheTimeout": null,
      "colorBackground": false,
      "colorValue": false,
      "colors": [
        "rgba(50, 172, 45, 0.97)",
        "rgba(237, 129, 40, 0.89)",
        "rgba(245, 54, 54, 0.9)"
      ],
      "datasource": "prometheus",
      "decimals": 2,
      "editable": true,
      "error": false,
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "format": "bytes",
      "gauge": {
        "maxValue": 100,
        "minValue": 0,
        "show": false,
        "thresholdLabels": false,
        "thresholdMarkers": true
      },
      "gridPos": {
        "h": 3,
        "w": 4,
        "x": 16,
        "y": 13
      },
      "height": "1px",
      "id": 13,
      "interval": null,
      "isNew": true,
      "links": [],
      "mappingType": 1,
      "mappingTypes": [
        {
          "name": "value to text",
          "value": 1
        },
        {
          "name": "range to text",
          "value": 2
        }
      ],
      "maxDataPoints": 100,
      "nullPointMode": "connected",
      "nullText": null,
      "postfix": "",
      "postfixFontSize": "50%",
      "prefix": "",
      "prefixFontSize": "50%",
      "rangeMaps": [
        {
          "from": "null",
          "text": "N/A",
          "to": "null"
        }
      ],
      "sparkline": {
        "fillColor": "rgba(31, 118, 189, 0.18)",
        "full": false,
        "lineColor": "rgb(31, 120, 193)",
        "show": false
      },
      "tableColumn": "",
      "targets": [
        {
          "expr": "sum (container_fs_usage_bytes{device=~\"^/dev/[sv]d[a-z][1-9]$\",id=\"/\",kubernetes_io_hostname=~\"^$Node$\"})",
          "interval": "10s",
          "intervalFactor": 1,
          "refId": "A",
          "step": 10
        }
      ],
      "thresholds": "",
      "title": "Used",
      "type": "singlestat",
      "valueFontSize": "50%",
      "valueMaps": [
        {
          "op": "=",
          "text": "N/A",
          "value": "null"
        }
      ],
      "valueName": "current"
    },
    {
      "cacheTimeout": null,
      "colorBackground": false,
      "colorValue": false,
      "colors": [
        "rgba(50, 172, 45, 0.97)",
        "rgba(237, 129, 40, 0.89)",
        "rgba(245, 54, 54, 0.9)"
      ],
      "datasource": "prometheus",
      "decimals": 2,
      "editable": true,
      "error": false,
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "format": "bytes",
      "gauge": {
        "maxValue": 100,
        "minValue": 0,
        "show": false,
        "thresholdLabels": false,
        "thresholdMarkers": true
      },
      "gridPos": {
        "h": 3,
        "w": 4,
        "x": 20,
        "y": 13
      },
      "height": "1px",
      "id": 14,
      "interval": null,
      "isNew": true,
      "links": [],
      "mappingType": 1,
      "mappingTypes": [
        {
          "name": "value to text",
          "value": 1
        },
        {
          "name": "range to text",
          "value": 2
        }
      ],
      "maxDataPoints": 100,
      "nullPointMode": "connected",
      "nullText": null,
      "postfix": "",
      "postfixFontSize": "50%",
      "prefix": "",
      "prefixFontSize": "50%",
      "rangeMaps": [
        {
          "from": "null",
          "text": "N/A",
          "to": "null"
        }
      ],
      "sparkline": {
        "fillColor": "rgba(31, 118, 189, 0.18)",
        "full": false,
        "lineColor": "rgb(31, 120, 193)",
        "show": false
      },
      "tableColumn": "",
      "targets": [
        {
          "expr": "sum (container_fs_limit_bytes{device=~\"^/dev/[sv]d[a-z][1-9]$\",id=\"/\",kubernetes_io_hostname=~\"^$Node$\"})",
          "interval": "10s",
          "intervalFactor": 1,
          "refId": "A",
          "step": 10
        }
      ],
      "thresholds": "",
      "title": "Total",
      "type": "singlestat",
      "valueFontSize": "50%",
      "valueMaps": [
        {
          "op": "=",
          "text": "N/A",
          "value": "null"
        }
      ],
      "valueName": "current"
    },
    {
      "collapsed": false,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 16
      },
      "id": 35,
      "panels": [],
      "title": "Pods CPU usage",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "prometheus",
      "decimals": 3,
      "editable": true,
      "error": false,
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "fill": 0,
      "fillGradient": 0,
      "grid": {},
      "gridPos": {
        "h": 7,
        "w": 24,
        "x": 0,
        "y": 17
      },
      "height": "",
      "hiddenSeries": false,
      "id": 17,
      "isNew": true,
      "legend": {
        "alignAsTable": true,
        "avg": true,
        "current": true,
        "max": false,
        "min": false,
        "rightSide": true,
        "show": true,
        "sort": "current",
        "sortDesc": true,
        "total": false,
        "values": true
      },
      "lines": true,
      "linewidth": 2,
      "links": [],
      "nullPointMode": "connected",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": true,
      "targets": [
        {
          "expr": "sum (rate (container_cpu_usage_seconds_total{image!=\"\",name=~\"^k8s_.*\",kubernetes_io_hostname=~\"^$Node$\"}[1m])) by (pod_name)",
          "interval": "10s",
          "intervalFactor": 1,
          "legendFormat": "{{ pod_name }}",
          "metric": "container_cpu",
          "refId": "A",
          "step": 10
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Pods CPU usage (1m avg)",
      "tooltip": {
        "msResolution": true,
        "shared": true,
        "sort": 2,
        "value_type": "cumulative"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "none",
          "label": "cores",
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": false
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "collapsed": true,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 24
      },
      "id": 36,
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "prometheus",
          "decimals": 3,
          "editable": true,
          "error": false,
          "fill": 0,
          "grid": {},
          "gridPos": {
            "h": 7,
            "w": 24,
            "x": 0,
            "y": 24
          },
          "height": "",
          "id": 23,
          "isNew": true,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "sort": "current",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": true,
          "targets": [
            {
              "expr": "sum (rate (container_cpu_usage_seconds_total{systemd_service_name!=\"\",kubernetes_io_hostname=~\"^$Node$\"}[1m])) by (systemd_service_name)",
              "hide": false,
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "{{ systemd_service_name }}",
              "metric": "container_cpu",
              "refId": "A",
              "step": 10
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "System services CPU usage (1m avg)",
          "tooltip": {
            "msResolution": true,
            "shared": true,
            "sort": 2,
            "value_type": "cumulative"
          },
          "type": "graph",
          "xaxis": {
            "show": true
          },
          "yaxes": [
            {
              "format": "none",
              "label": "cores",
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": false
            }
          ]
        }
      ],
      "title": "System services CPU usage",
      "type": "row"
    },
    {
      "collapsed": true,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 25
      },
      "id": 37,
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "prometheus",
          "decimals": 3,
          "editable": true,
          "error": false,
          "fill": 0,
          "grid": {},
          "gridPos": {
            "h": 7,
            "w": 24,
            "x": 0,
            "y": 25
          },
          "height": "",
          "id": 24,
          "isNew": true,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "hideEmpty": false,
            "hideZero": false,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "sideWidth": null,
            "sort": "current",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": true,
          "targets": [
            {
              "expr": "sum (rate (container_cpu_usage_seconds_total{image!=\"\",name=~\"^k8s_.*\",container_name!=\"POD\",kubernetes_io_hostname=~\"^$Node$\"}[1m])) by (container_name, pod_name)",
              "hide": false,
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "pod: {{ pod_name }} | {{ container_name }}",
              "metric": "container_cpu",
              "refId": "A",
              "step": 10
            },
            {
              "expr": "sum (rate (container_cpu_usage_seconds_total{image!=\"\",name!~\"^k8s_.*\",kubernetes_io_hostname=~\"^$Node$\"}[1m])) by (kubernetes_io_hostname, name, image)",
              "hide": false,
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "docker: {{ kubernetes_io_hostname }} | {{ image }} ({{ name }})",
              "metric": "container_cpu",
              "refId": "B",
              "step": 10
            },
            {
              "expr": "sum (rate (container_cpu_usage_seconds_total{rkt_container_name!=\"\",kubernetes_io_hostname=~\"^$Node$\"}[1m])) by (kubernetes_io_hostname, rkt_container_name)",
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "rkt: {{ kubernetes_io_hostname }} | {{ rkt_container_name }}",
              "metric": "container_cpu",
              "refId": "C",
              "step": 10
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Containers CPU usage (1m avg)",
          "tooltip": {
            "msResolution": true,
            "shared": true,
            "sort": 2,
            "value_type": "cumulative"
          },
          "type": "graph",
          "xaxis": {
            "show": true
          },
          "yaxes": [
            {
              "format": "none",
              "label": "cores",
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": false
            }
          ]
        }
      ],
      "title": "Containers CPU usage",
      "type": "row"
    },
    {
      "collapsed": true,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 26
      },
      "id": 38,
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "prometheus",
          "decimals": 3,
          "editable": true,
          "error": false,
          "fill": 0,
          "grid": {},
          "gridPos": {
            "h": 14,
            "w": 24,
            "x": 0,
            "y": 26
          },
          "id": 20,
          "isNew": true,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": false,
            "show": true,
            "sort": "current",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": true,
          "targets": [
            {
              "expr": "sum (rate (container_cpu_usage_seconds_total{id!=\"/\",kubernetes_io_hostname=~\"^$Node$\"}[1m])) by (id)",
              "hide": false,
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "{{ id }}",
              "metric": "container_cpu",
              "refId": "A",
              "step": 10
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "All processes CPU usage (1m avg)",
          "tooltip": {
            "msResolution": true,
            "shared": true,
            "sort": 2,
            "value_type": "cumulative"
          },
          "type": "graph",
          "xaxis": {
            "show": true
          },
          "yaxes": [
            {
              "format": "none",
              "label": "cores",
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": false
            }
          ]
        }
      ],
      "repeat": null,
      "title": "All processes CPU usage",
      "type": "row"
    },
    {
      "collapsed": false,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 27
      },
      "id": 39,
      "panels": [],
      "title": "Pods memory usage",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "prometheus",
      "decimals": 2,
      "editable": true,
      "error": false,
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "fill": 0,
      "fillGradient": 0,
      "grid": {},
      "gridPos": {
        "h": 7,
        "w": 24,
        "x": 0,
        "y": 28
      },
      "hiddenSeries": false,
      "id": 25,
      "isNew": true,
      "legend": {
        "alignAsTable": true,
        "avg": true,
        "current": true,
        "max": false,
        "min": false,
        "rightSide": true,
        "show": true,
        "sideWidth": 200,
        "sort": "current",
        "sortDesc": true,
        "total": false,
        "values": true
      },
      "lines": true,
      "linewidth": 2,
      "links": [],
      "nullPointMode": "connected",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": true,
      "targets": [
        {
          "expr": "sum (container_memory_working_set_bytes{image!=\"\",name=~\"^k8s_.*\",kubernetes_io_hostname=~\"^$Node$\"}) by (pod_name)",
          "interval": "10s",
          "intervalFactor": 1,
          "legendFormat": "{{ pod_name }}",
          "metric": "container_memory_usage:sort_desc",
          "refId": "A",
          "step": 10
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Pods memory usage",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 2,
        "value_type": "cumulative"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "bytes",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": false
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "collapsed": true,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 35
      },
      "id": 40,
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "prometheus",
          "decimals": 2,
          "editable": true,
          "error": false,
          "fill": 0,
          "grid": {},
          "gridPos": {
            "h": 7,
            "w": 24,
            "x": 0,
            "y": 35
          },
          "id": 26,
          "isNew": true,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "sideWidth": 200,
            "sort": "current",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": true,
          "targets": [
            {
              "expr": "sum (container_memory_working_set_bytes{systemd_service_name!=\"\",kubernetes_io_hostname=~\"^$Node$\"}) by (systemd_service_name)",
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "{{ systemd_service_name }}",
              "metric": "container_memory_usage:sort_desc",
              "refId": "A",
              "step": 10
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "System services memory usage",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 2,
            "value_type": "cumulative"
          },
          "type": "graph",
          "xaxis": {
            "show": true
          },
          "yaxes": [
            {
              "format": "bytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": false
            }
          ]
        }
      ],
      "title": "System services memory usage",
      "type": "row"
    },
    {
      "collapsed": true,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 36
      },
      "id": 41,
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "prometheus",
          "decimals": 2,
          "editable": true,
          "error": false,
          "fill": 0,
          "grid": {},
          "gridPos": {
            "h": 7,
            "w": 24,
            "x": 0,
            "y": 36
          },
          "id": 27,
          "isNew": true,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "sideWidth": 200,
            "sort": "current",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": true,
          "targets": [
            {
              "expr": "sum (container_memory_working_set_bytes{image!=\"\",name=~\"^k8s_.*\",container_name!=\"POD\",kubernetes_io_hostname=~\"^$Node$\"}) by (container_name, pod_name)",
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "pod: {{ pod_name }} | {{ container_name }}",
              "metric": "container_memory_usage:sort_desc",
              "refId": "A",
              "step": 10
            },
            {
              "expr": "sum (container_memory_working_set_bytes{image!=\"\",name!~\"^k8s_.*\",kubernetes_io_hostname=~\"^$Node$\"}) by (kubernetes_io_hostname, name, image)",
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "docker: {{ kubernetes_io_hostname }} | {{ image }} ({{ name }})",
              "metric": "container_memory_usage:sort_desc",
              "refId": "B",
              "step": 10
            },
            {
              "expr": "sum (container_memory_working_set_bytes{rkt_container_name!=\"\",kubernetes_io_hostname=~\"^$Node$\"}) by (kubernetes_io_hostname, rkt_container_name)",
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "rkt: {{ kubernetes_io_hostname }} | {{ rkt_container_name }}",
              "metric": "container_memory_usage:sort_desc",
              "refId": "C",
              "step": 10
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Containers memory usage",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 2,
            "value_type": "cumulative"
          },
          "type": "graph",
          "xaxis": {
            "show": true
          },
          "yaxes": [
            {
              "format": "bytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": false
            }
          ]
        }
      ],
      "title": "Containers memory usage",
      "type": "row"
    },
    {
      "collapsed": true,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 37
      },
      "id": 42,
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "prometheus",
          "decimals": 2,
          "editable": true,
          "error": false,
          "fill": 0,
          "grid": {},
          "gridPos": {
            "h": 14,
            "w": 24,
            "x": 0,
            "y": 37
          },
          "id": 28,
          "isNew": true,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": false,
            "show": true,
            "sideWidth": 200,
            "sort": "current",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": true,
          "targets": [
            {
              "expr": "sum (container_memory_working_set_bytes{id!=\"/\",kubernetes_io_hostname=~\"^$Node$\"}) by (id)",
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "{{ id }}",
              "metric": "container_memory_usage:sort_desc",
              "refId": "A",
              "step": 10
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "All processes memory usage",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 2,
            "value_type": "cumulative"
          },
          "type": "graph",
          "xaxis": {
            "show": true
          },
          "yaxes": [
            {
              "format": "bytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": false
            }
          ]
        }
      ],
      "title": "All processes memory usage",
      "type": "row"
    },
    {
      "collapsed": false,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 38
      },
      "id": 43,
      "panels": [],
      "title": "Pods network I/O",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "prometheus",
      "decimals": 2,
      "editable": true,
      "error": false,
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "grid": {},
      "gridPos": {
        "h": 7,
        "w": 24,
        "x": 0,
        "y": 39
      },
      "hiddenSeries": false,
      "id": 16,
      "isNew": true,
      "legend": {
        "alignAsTable": true,
        "avg": true,
        "current": true,
        "max": false,
        "min": false,
        "rightSide": true,
        "show": true,
        "sideWidth": 200,
        "sort": "current",
        "sortDesc": true,
        "total": false,
        "values": true
      },
      "lines": true,
      "linewidth": 2,
      "links": [],
      "nullPointMode": "connected",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "expr": "sum (rate (container_network_receive_bytes_total{image!=\"\",name=~\"^k8s_.*\",kubernetes_io_hostname=~\"^$Node$\"}[1m])) by (pod_name)",
          "interval": "10s",
          "intervalFactor": 1,
          "legendFormat": "-> {{ pod_name }}",
          "metric": "network",
          "refId": "A",
          "step": 10
        },
        {
          "expr": "- sum (rate (container_network_transmit_bytes_total{image!=\"\",name=~\"^k8s_.*\",kubernetes_io_hostname=~\"^$Node$\"}[1m])) by (pod_name)",
          "interval": "10s",
          "intervalFactor": 1,
          "legendFormat": "<- {{ pod_name }}",
          "metric": "network",
          "refId": "B",
          "step": 10
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Pods network I/O (1m avg)",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 2,
        "value_type": "cumulative"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "Bps",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": false
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "collapsed": true,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 46
      },
      "id": 44,
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "prometheus",
          "decimals": 2,
          "editable": true,
          "error": false,
          "fill": 1,
          "grid": {},
          "gridPos": {
            "h": 7,
            "w": 24,
            "x": 0,
            "y": 46
          },
          "id": 30,
          "isNew": true,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "sideWidth": 200,
            "sort": "current",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "sum (rate (container_network_receive_bytes_total{image!=\"\",name=~\"^k8s_.*\",kubernetes_io_hostname=~\"^$Node$\"}[1m])) by (container_name, pod_name)",
              "hide": false,
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "-> pod: {{ pod_name }} | {{ container_name }}",
              "metric": "network",
              "refId": "B",
              "step": 10
            },
            {
              "expr": "- sum (rate (container_network_transmit_bytes_total{image!=\"\",name=~\"^k8s_.*\",kubernetes_io_hostname=~\"^$Node$\"}[1m])) by (container_name, pod_name)",
              "hide": false,
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "<- pod: {{ pod_name }} | {{ container_name }}",
              "metric": "network",
              "refId": "D",
              "step": 10
            },
            {
              "expr": "sum (rate (container_network_receive_bytes_total{image!=\"\",name!~\"^k8s_.*\",kubernetes_io_hostname=~\"^$Node$\"}[1m])) by (kubernetes_io_hostname, name, image)",
              "hide": false,
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "-> docker: {{ kubernetes_io_hostname }} | {{ image }} ({{ name }})",
              "metric": "network",
              "refId": "A",
              "step": 10
            },
            {
              "expr": "- sum (rate (container_network_transmit_bytes_total{image!=\"\",name!~\"^k8s_.*\",kubernetes_io_hostname=~\"^$Node$\"}[1m])) by (kubernetes_io_hostname, name, image)",
              "hide": false,
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "<- docker: {{ kubernetes_io_hostname }} | {{ image }} ({{ name }})",
              "metric": "network",
              "refId": "C",
              "step": 10
            },
            {
              "expr": "sum (rate (container_network_transmit_bytes_total{rkt_container_name!=\"\",kubernetes_io_hostname=~\"^$Node$\"}[1m])) by (kubernetes_io_hostname, rkt_container_name)",
              "hide": false,
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "-> rkt: {{ kubernetes_io_hostname }} | {{ rkt_container_name }}",
              "metric": "network",
              "refId": "E",
              "step": 10
            },
            {
              "expr": "- sum (rate (container_network_transmit_bytes_total{rkt_container_name!=\"\",kubernetes_io_hostname=~\"^$Node$\"}[1m])) by (kubernetes_io_hostname, rkt_container_name)",
              "hide": false,
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "<- rkt: {{ kubernetes_io_hostname }} | {{ rkt_container_name }}",
              "metric": "network",
              "refId": "F",
              "step": 10
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Containers network I/O (1m avg)",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 2,
            "value_type": "cumulative"
          },
          "type": "graph",
          "xaxis": {
            "show": true
          },
          "yaxes": [
            {
              "format": "Bps",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": false
            }
          ]
        }
      ],
      "title": "Containers network I/O",
      "type": "row"
    },
    {
      "collapsed": true,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 47
      },
      "id": 45,
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "prometheus",
          "decimals": 2,
          "editable": true,
          "error": false,
          "fill": 1,
          "grid": {},
          "gridPos": {
            "h": 14,
            "w": 24,
            "x": 0,
            "y": 47
          },
          "id": 29,
          "isNew": true,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": false,
            "min": false,
            "rightSide": false,
            "show": true,
            "sideWidth": 200,
            "sort": "current",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "sum (rate (container_network_receive_bytes_total{id!=\"/\",kubernetes_io_hostname=~\"^$Node$\"}[1m])) by (id)",
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "-> {{ id }}",
              "metric": "network",
              "refId": "A",
              "step": 10
            },
            {
              "expr": "- sum (rate (container_network_transmit_bytes_total{id!=\"/\",kubernetes_io_hostname=~\"^$Node$\"}[1m])) by (id)",
              "interval": "10s",
              "intervalFactor": 1,
              "legendFormat": "<- {{ id }}",
              "metric": "network",
              "refId": "B",
              "step": 10
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "All processes network I/O (1m avg)",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 2,
            "value_type": "cumulative"
          },
          "type": "graph",
          "xaxis": {
            "show": true
          },
          "yaxes": [
            {
              "format": "Bps",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": false
            }
          ]
        }
      ],
      "title": "All processes network I/O",
      "type": "row"
    }
  ],
  "refresh": "5s",
  "schemaVersion": 27,
  "style": "dark",
  "tags": [
    "kubernetes"
  ],
  "templating": {
    "list": [
      {
        "allValue": ".*",
        "current": {
          "selected": false,
          "text": "node1",
          "value": "node1"
        },
        "datasource": "prometheus",
        "definition": "",
        "description": null,
        "error": null,
        "hide": 0,
        "includeAll": true,
        "label": null,
        "multi": false,
        "name": "Node",
        "options": [],
        "query": {
          "query": "label_values(kubernetes_io_hostname)",
          "refId": "prometheus-Node-Variable-Query"
        },
        "refresh": 1,
        "regex": "",
        "skipUrlSync": false,
        "sort": 0,
        "tagValuesQuery": "",
        "tags": [],
        "tagsQuery": "",
        "type": "query",
        "useTags": false
      }
    ]
  },
  "time": {
    "from": "now-5m",
    "to": "now"
  },
  "timepicker": {
    "refresh_intervals": [
      "5s",
      "10s",
      "30s",
      "1m",
      "5m",
      "15m",
      "30m",
      "1h",
      "2h",
      "1d"
    ],
    "time_options": [
      "5m",
      "15m",
      "1h",
      "6h",
      "12h",
      "24h",
      "2d",
      "7d",
      "30d"
    ]
  },
  "timezone": "browser",
  "title": "Kubernetes cluster monitoring (via Prometheus)",
  "uid": "LWsORlqMz",
  "version": 2
}' "${grafana_url}/api/dashboards/db"
