!/bin/bash

Call vm_stat only once
VM_STAT=$(vm_stat)

# Parse page size robustly
PAGE_SIZE=$(echo "$VM_STAT" | awk '/page size of/ {print $8}')

# Total memory in bytes
TOTAL=$(sysctl -n hw.memsize)

# Extract page counts (remove trailing dots)
ACTIVE=$(echo "$VM_STAT"     | awk '/Pages active:/              {gsub(/\./, "", $3); print $3}')
WIRED=$(echo "$VM_STAT"      | awk '/Pages wired down:/          {gsub(/\./, "", $4); print $4}')
COMPRESSED=$(echo "$VM_STAT" | awk '/Pages occupied by compressor:/ {gsub(/\./, "", $5); print $5}')

# Guard against empty values
ACTIVE=${ACTIVE:-0}
WIRED=${WIRED:-0}
COMPRESSED=${COMPRESSED:-0}

USED_BYTES=$(( (ACTIVE + WIRED + COMPRESSED) * PAGE_SIZE ))
PERCENT=$(( USED_BYTES * 100 / TOTAL ))

USED_GB=$(awk "BEGIN {printf \"%.1f\", $USED_BYTES/1024/1024/1024}")
TOTAL_GB=$(awk "BEGIN {printf \"%.0f\", $TOTAL/1024/1024/1024}")

sketchybar --set "$NAME" icon="􀫦" label="${USED_GB}/${TOTAL_GB}GB"
