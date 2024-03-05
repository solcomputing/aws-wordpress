#!/bin/bash


SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
WORKING_DIR=tf/infra

declare -A _SETTINGS

export TF_VAR_ENV_VAULT_TOKEN=""

function init()
{
   _WORKING_DIR=${SCRIPTPATH}/$1

   echo "CURRENT_WORKING_DIRECTORY:${_WORKING_DIR}"
   terraform -chdir=${_WORKING_DIR} init
}

function start()
{
   _WORKING_DIR=${SCRIPTPATH}/$1

   terraform -chdir=${_WORKING_DIR} init
   terraform -chdir=${_WORKING_DIR} plan
   terraform -chdir=${_WORKING_DIR} apply -auto-approve
}

function destroy()
{
  _WORKING_DIR=${SCRIPTPATH}/$1

  terraform -chdir=${WORKING_DIR} destroy -auto-approve
}

function unsetenv()
{
    sed -i s/$(terraform workspace show | tr -d '\n')/%env%/g ${SCRIPTPATH}/${WORKING_DIR}/setting.values
    sed -i s/$(terraform workspace show | tr -d '\n')/%WORKSPACE%/g ${SCRIPTPATH}/${WORKING_DIR}/provider.tf
}

function setenv()
{
    sed -i s/%env%/$(terraform workspace show | tr -d '\n')/g ${SCRIPTPATH}/${WORKING_DIR}/setting.values
    if [ -f ${SCRIPTPATH}/${WORKING_DIR}/setting.values ]; then
      while read line
        do
           _KEY=$(echo -n $line   | awk -F'=' '{print $1}')
           _VALUE=$(echo -n $line | awk -F'=' '{print $2}')
           _SETTINGS[${_KEY}]="${_VALUE}"
        done < ${SCRIPTPATH}/${WORKING_DIR}/setting.values
    fi
    for key in "${!_SETTINGS[@]}"
    do
          v=${_SETTINGS[${key}]}
          sed -i s/%$key%/$v/g ${SCRIPTPATH}/${WORKING_DIR}/provider.tf 
    done
}

setenv

  while getopts "isdp:" opt;
    do
       case $opt in
       i)
          init  ${WORKING_DIR}
          ;;
       s)
          start ${WORKING_DIR}
	      ;;
       d)
          destroy ${WORKING_DIR}
          ;;
       p)
          WORKING_DIR=$OPTARG
          ;; 
	   \?)
	      exit 1
          ;;
       esac
   done

unsetenv