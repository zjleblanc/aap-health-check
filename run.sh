#!/bin/bash

ansible-playbook pb_health_check.yml -i inventory.local.yml --skip-tags debug
nginx -g "daemon off;"