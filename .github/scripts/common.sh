#!/usr/bin/env bash

get_changed_dockerfiles() {
    echo $(git diff --name-only HEAD^1 |
        awk '/Dockerfile/&&!/templates/')
}
