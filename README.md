# Hiro Systems Helm Charts

This repository contains Helm charts for deploying Hiro Systems infrastructure components, including the Stacks blockchain node and associated services.

## ⚠️ Important Notice

**These Helm charts are primarily designed and optimized for Hiro's internal infrastructure.** While they are publicly available, they are:

- Highly tailored to Hiro's specific deployment environment
- Not intended as authoritative guides for running Hiro software
- Not guaranteed to account for all deployment scenarios

**If you're experiencing performance issues**, it's likely due to using default configurations without proper tuning for your specific environment.

## Available Charts

- **stacks-blockchain** - Deploys a Stacks blockchain node
- **stacks-blockchain-api** - Deploys the Stacks Blockchain API service
- Additional supporting services and components

## Prerequisites

- Kubernetes 1.19+
- Helm 3.x
- Understanding of Kubernetes resource management and configuration
- Familiarity with the Stacks blockchain architecture

## Getting Started

### Adding the Repository

```bash
helm repo add hirosystems https://hirosystems.github.io/charts
helm repo update
```

### Installing Charts

```bash
# Install with default values (NOT recommended for production)
helm install my-stacks-node hirosystems/stacks-blockchain

# Install with custom values (RECOMMENDED)
helm install my-stacks-node hirosystems/stacks-blockchain -f my-values.yaml
```

## ⚡ Performance Considerations

**Chart configuration does not determine application performance.** Performance depends on:

1. **Resource Allocation**
   - CPU and memory limits/requests
   - Storage class and IOPS
   - Network bandwidth

2. **Application Configuration**
   - Node settings and parameters
   - Cache sizes
   - Connection pools
   - Indexing strategies

3. **Infrastructure**
   - Node types and specifications
   - Cluster networking setup
   - Storage backend performance

### Tuning for Production

If you're deploying these charts in production, you **MUST**:

1. **Review and modify resource requests/limits** based on your workload
2. **Configure application-specific settings** for optimal performance
3. **Use appropriate storage classes** with sufficient IOPS
4. **Monitor and adjust** based on actual usage patterns

Example custom values for production:

```yaml
# my-values.yaml
resources:
  requests:
    memory: "8Gi"
    cpu: "4"
  limits:
    memory: "16Gi"
    cpu: "8"

persistence:
  size: 500Gi
  storageClass: fast-ssd

config:
  # Application-specific tuning parameters
  # Consult Stacks documentation for optimal values
  cache_size: 4096
  max_connections: 1000
  # ... other configuration
```

## Your Mileage May Vary (YMMV)

Since these charts are optimized for Hiro's infrastructure:

- Network policies may reference internal services
- Default values assume specific cluster configurations
- Some features may require Hiro-specific resources
- Monitoring and observability integrations may not work out-of-the-box

**Experienced Kubernetes operators** can adapt these charts by:
- Overriding values extensively
- Modifying templates if necessary
- Understanding the underlying application requirements

## Troubleshooting

### Common Issues

1. **Poor Performance**
   - Check resource allocation
   - Review application logs for bottlenecks
   - Ensure storage performance meets requirements
   - Verify network connectivity and latency

2. **Deployment Failures**
   - Verify all dependencies are met
   - Check for namespace-specific resources
   - Review security contexts and permissions

3. **Connection Issues**
   - Confirm service discovery is working
   - Check network policies
   - Verify ingress/load balancer configuration

## Documentation

For comprehensive information about running Stacks infrastructure:

- [Stacks Documentation](https://docs.stacks.co)
- [Hiro Developer Docs](https://docs.hiro.so)
- [Stacks Blockchain Configuration](https://docs.stacks.co/docs/nodes-and-miners)

## Support

- **For Helm chart issues**: Open an issue in this repository
- **For application-specific questions**: Consult the official documentation
- **For performance tuning**: Review the Stacks performance tuning guide

## Contributing

We welcome contributions that:
- Improve compatibility across different environments
- Add better documentation and examples
- Fix bugs or security issues

Please ensure any changes maintain backward compatibility with Hiro's infrastructure needs.

**Remember**: These charts are tools to help deploy the software, not prescriptive guides on how to run it. Successful deployment requires understanding both Kubernetes and the Stacks blockchain ecosystem.
