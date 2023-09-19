#!/bin/bash
sudo yum remove nss-pem
sudo yum downgrade\
	nss-3.53.1-3.el7_9.x86_64\
	nss-devel-3.53.1-3.el7_9.x86_64\
	nss-tools-3.53.1-3.el7_9.x86_64\
	nss-sysinit-3.53.1-3.el7_9.x86_64
