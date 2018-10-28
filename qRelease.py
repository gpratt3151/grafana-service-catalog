#!/usr/bin/python
#Need to install requests package for python
#easy_install requests
import requests

# Set the request parameters
url = 'https://dev99999.service-now.com/api/now/table/rm_story?sysparm_query=release%3D5b82b3f54f112300825b00fe9310c70b&sysparm_fields=number&sysparm_limit=10'

# Eg. User name="admin", Password="admin" for this code sample.
user = 'admin'
pwd = 'PASSWORD'

# Set proper headers
headers = {"Content-Type":"application/json","Accept":"application/json"}

# Do the HTTP request
response = requests.get(url, auth=(user, pwd), headers=headers )

# Check for HTTP codes other than 200
if response.status_code != 200: 
    print('Status:', response.status_code, 'Headers:', response.headers, 'Error Response:',response.json())
    exit()

# print('Status:', response.status_code, 'Headers:', response.headers, 'Error Response:',response.json())

print(response.headers['X-Total-Count'])

# Decode the JSON response into a dictionary and use the data
data = response.json()
print(data)
