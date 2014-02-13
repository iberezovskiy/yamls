#!/bin/bash

jenkins-jobs --ignore-cache --conf /etc/jenkins_jobs/jenkins_jobs.ini update $(pwd)/jobs/
