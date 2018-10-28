# grafana-service-catalog
Service Catalog Items created

# Grafana Datasource
```
Name: Service Catalog Items
Type: InfluxDB
URL: http://localhost:8086
Access: Server (Default)
Database: service_catalog
```

# ServiceNow Rest API Explorer
[Encoded query strings documentation](https://docs.servicenow.com/bundle/london-platform-user-interface/page/use/using-lists/concept/c_EncodedQueryStrings.html)

## Example: Count of story and story numbers for a release
```
tableName: rm_story
sysparm_query: release=e680xb95dbd9ecc4bd065055ca961918
sysparm_fields: number

From the Header we want: X-Total-Count
```
