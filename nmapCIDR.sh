#!/bin/bash


if [ -z "$1" ]; then
  echo "Usage: $0 <CIDR-range>"
  echo "Example: $0 10.10.0.0/16"
  exit 1
fi

CIDR=$1
MAX_PARALLEL=10  # Number of concurrent scans


function calculate_subnets() {
  local cidr_prefix=$(echo "$1" | cut -d'/' -f1)
  local base_ip=$(echo "$cidr_prefix" | awk -F '.' '{print $1"."$2}')
  for i in {0..255}; do
    echo "$base_ip.$i.0/24"
  done
}


function scan_and_display() {
  local subnet=$1
  {
    echo "Scanning subnet: $subnet"
    nmap -n -sn "$subnet" -oG - | awk '/Up$/{print $2}'
  }
}


subnets=$(calculate_subnets "$CIDR")


export -f scan_and_display

echo "$subnets" | parallel -j "$MAX_PARALLEL" --keep-order scan_and_display
