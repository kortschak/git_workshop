#!/usr/bin/env bash

if [[ $1 -eq 0 ]]; then
	echo must have at least one participant
	exit 2
fi

n=$1

(for p in {1..$n}; do echo -e "Person\n\n$p\n\n\n"; done) > PARTICIPANTS.md
