#!/bin/sh

pipenv sync

exec pipenv run python -m HABApp "$@"
