#!/bin/sh
# First failure stops the local push.
run_check 'pnpm install --lockfile-only --frozen-lockfile --ignore-scripts'
