#!/bin/bash

## Author ----------------------------
# @notchum

## Description ----------------------------
# Quickly create a virtual environment for
# Python.

python -m venv .venv
source .venv/bin/activate
[[ -f requirements.txt ]] && pip install -r requirements.txt
