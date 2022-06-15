#!/bin/bash
now=$(date --iso-8601)
sed -i.bak -E "s/[0-9]{4}-[0-9]{2}-[0-9]{2}/$now/" notes.sql
