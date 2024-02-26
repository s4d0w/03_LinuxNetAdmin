#!/bin/bash

mkdir -p /backup

cd /home 
tar czf /backup/home_$(date +%m%d_%H%M%S).tar.gz . > /backup/backup.log 2>&1

