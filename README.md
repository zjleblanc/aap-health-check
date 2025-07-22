# aap-health-check

Lightweight automation designed to periodically run a health check playbook against an Ansible Automation Platform instance.

Report design based on [Red Hat Access article](https://access.redhat.com/solutions/7113839) outlining how to perform a health check of Ansible Automation Platform.

## usage

The containerized deployment for a one-shot report is publicly avaiable in Quay<br>
`podman pull quay.io/zleblanc/aap-health-check`

The report is dependent on environment variables provided at runtime. See instructions below based on your version of AAP.

### version agnostic

```
HEALTH_CHECK_VALIDATE_CERTS="True" # validate AAP SSL certificates
```

### 2.5+

Create a token for a user with required permissions. The report has been tested using a System Auditor token with read scope. Tokens can be created by navigating to **Access Management > Users > {Logged In User} > Tokens > Create Token**.

The following environment variables will be required to generate the report:
```
GATEWAY_HOSTNAME="https://aap.example.com"
GATEWAY_API_TOKEN="s3cr3t"
```

For security purposes, I recommend passing the token as a podman secret. You can create a podman secret from the token environment variable with the following command:<br>
```
podman secret create --env=true gateway_token GATEWAY_API_TOKEN
```

Finally, you can provide enviroment variables to the container using the following arguments:
```
podman run -p 8080:8080 \
  --env GATEWAY_HOSTNAME="https://aap.example.com" \
  --secret gateway_token,type=env,target=GATEWAY_API_TOKEN \
  quay.io/zleblanc/aap-health-check
```

### 2.4 (and earlier)

Create a token for a user with required permissions. For a comprehensive report, you will need to create a token for Controller and Private Automation Hub.

The following environment variables will be required to generate the report:
```
CONTROLLER_HOSTNAME="https://controller.example.com"
CONTROLLER_API_TOKEN="s3cr3t"
PAH_HOSTNAME="https://pah.example.com"
PAH_API_TOKEN="s3cr3t"
```

For security purposes, I recommend passing the token as a podman secret. You can create a podman secret from the token environment variable with the following command:<br>
```
podman secret create --env=true controller_token CONTROLLER_API_TOKEN
podman secret create --env=true pah_token PAH_API_TOKEN
```

Finally, you can provide enviroment variables to the container using the following arguments:
```
podman run -p 8080:8080 \
  --env CONTROLLER_HOSTNAME="https://controller.example.com" \
  --secret controller_token,type=env,target=CONTROLLER_API_TOKEN \
  --env PAH_HOSTNAME="https://pah.example.com" \
  --secret pah_token,type=env,target=PAH_API_TOKEN \
  quay.io/zleblanc/aap-health-check
```

## healthy report (v1)

[Static Report](https://reports.autodotes.com/misc/aap_health_check.html)

![Healthy AAP Report](./.attachments/health_check_report_v1.png)