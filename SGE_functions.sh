#!/usr/bin/env bash


function killjobs()
{
    for job in `qstat | awk '{print $1}' | xargs`; do qdel $job; done
}
