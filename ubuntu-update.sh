#!/bin/bash

apt update -y

apt dist-upgrade -y

timedatectl set-timezone Asia/Kolkata

hostnamectl set-hostname k8s-master
