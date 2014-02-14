#!/bin/bash

jenkins-jobs --ignore-cache --conf $(pwd)/config update $(pwd)/jobs/
