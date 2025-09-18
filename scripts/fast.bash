#!/usr/bin/env bash
# fast.bash - quick check for common network troubleshooting tools with colored results

set -euo pipefail

GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
NC="\033[0m"

TOOLS=(ping traceroute curl wget dig nc mtr ip ifconfig ss telnet arp)

installed=0
missing=0
missing_list=()

get_version() {
    local bin="$1"
    local out first
    for flag in --version -V -v version; do
        out=$("$bin" "$flag" 2>&1 || true)
        if [[ -n "$out" ]]; then
            first=$(printf '%s\n' "$out" | sed -n '1p' | tr -d '\r')
            # skip obvious help/usage lines
            if printf '%s\n' "$first" | grep -qiE 'usage|help'; then
                continue
            fi
            # limit length
            printf '%s' "${first:0:120}"
            return 0
        fi
    done
    return 1
}

printf "%s\n" "Checking basic network troubleshooting tools..."
printf '%s\n' "---------------------------------------------"

for t in "${TOOLS[@]}"; do
    if cmd_path=$(command -v "$t" 2>/dev/null); then
        if ver=$(get_version "$cmd_path"); then
            printf "%-12s : ${GREEN}INSTALLED${NC} %s\n" "$t" "($ver)"
        else
            printf "%-12s : ${GREEN}INSTALLED${NC}\n" "$t"
        fi
        installed=$((installed + 1))
    else
        printf "%-12s : ${RED}MISSING${NC}\n" "$t"
        missing=$((missing + 1))
        missing_list+=("$t")
    fi
done

printf '%s\n' "---------------------------------------------"
if [[ $missing -eq 0 ]]; then
    printf "${GREEN}ALL TOOLS AVAILABLE${NC} — %d checked\n" "$installed"
    exit 0
else
    printf "${YELLOW}SUMMARY:${NC} %d present, ${RED}%d missing${NC}\n" "$installed" "$missing"
    printf "Missing: %s\n" "${missing_list[*]}"
fi