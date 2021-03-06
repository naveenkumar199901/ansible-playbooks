#!/usr/bin/env bash

echo  "Define cluster for sidecar's discovered instances"
/opt/mesh/greymatter create cluster < control-api/cluster-instance.json

echo "Define rule for directing traffic to sidecar cluster"
/opt/mesh/greymatter create shared_rules < control-api/shared-rules-sidecar.json

echo "Add route #1 from edge to sidecar (no trailing slash)"
/opt/mesh/greymatter create route < control-api/route-sidecar.json

echo "Add route #2 from edge to sidecar (with trailing slash)"
/opt/mesh/greymatter create route < control-api/route-slash.json

echo "Define cluster for a sidecar's service"
# Note: Service is at localhost:port (same EC2)
/opt/mesh/greymatter create cluster < control-api/cluster-service.json

echo "Define rule for directing traffic to service cluster"
/opt/mesh/greymatter create shared_rules < control-api/shared-rules-service.json

echo "Define domain for sidecar route to its service"
/opt/mesh/greymatter create domain < control-api/domain.json

echo "Define listener for downstream requests to sidecar"
/opt/mesh/greymatter create listener < control-api/listener.json

echo "Define proxy"
/opt/mesh/greymatter create proxy < control-api/proxy.json

echo "Add route from sidecar to service cluster"
/opt/mesh/greymatter create route < control-api/route-service.json
