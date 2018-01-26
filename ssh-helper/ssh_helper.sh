#!/bin/sh
BASE_FOLDER="/keys"
KEY_FILE="${BASE_FOLDER}/codeship_deploy_key"
ENV_FILE="${BASE_FOLDER}/codeship.env"

ACTION=$1 && shift

case "${ACTION}" in
	generate)
		EMAIL=$1 && shift
		ssh-keygen -t rsa -b 4096 -t rsa -N '' -C "Codeship Deploy key, generated by ${EMAIL}" -f "${KEY_FILE}"
		;;
	prepare)
		echo "PRIVATE_SSH_KEY=$(sed -E ':a;N;$!ba;s/\r?\n/\\n/g' "${KEY_FILE}")" >> "${ENV_FILE}"
		;;
	write)
		mkdir -p "${BASE_FOLDER}/.ssh/"
		printf "${PRIVATE_SSH_KEY}" >> "${BASE_FOLDER}/.ssh/id_rsa"
		;;
	*)
		echo "Usage: $0 {generate|encrypt|prepare}"
		exit 1
esac
