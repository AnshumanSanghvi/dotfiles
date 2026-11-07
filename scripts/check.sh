#!/bin/sh
# scripts/check.sh: lint and smoke-test the zsh configuration.
#   1. `zsh -n` (parse only) on every tracked zsh file.
#   2. An interactive startup (`zsh -i -c exit`) that must exit 0 with NO output on stderr.
#   3. A secret scan with gitleaks (staged changes and committed history), when installed.
# POSIX sh, so `sh scripts/check.sh`, `bash scripts/check.sh` and ./scripts/check.sh all work.
# Run by hand, or before each commit via .githooks/pre-commit
# (enable with: git config core.hooksPath .githooks).
cd "$(dirname "$0")/.." || exit 1

if ! command -v zsh >/dev/null 2>&1; then
    echo "check.sh: zsh not found" >&2
    exit 1
fi

fail=0

echo "== syntax (zsh -n)"
for f in $(git ls-files zsh aliases functions integrations); do
    case $f in *.txt) continue ;; esac
    if ! out=$(zsh -n "$f" 2>&1); then
        echo "FAIL: $f"
        echo "$out"
        fail=1
    fi
done

echo "== startup smoke test (interactive, forced)"
err=$(ZSH_FORCE_INTERACTIVE_RC=1 zsh -i -c exit 2>&1 >/dev/null)
status=$?
if [ "$status" -ne 0 ]; then
    echo "FAIL: zsh -i -c exit returned $status"
    fail=1
fi
if [ -n "$err" ]; then
    echo "FAIL: startup wrote to stderr:"
    echo "$err"
    fail=1
fi

echo "== secret scan (gitleaks)"
if command -v gitleaks >/dev/null 2>&1; then
    for mode in "git --staged" "git"; do
        # $mode is split on purpose: it is a subcommand plus its flag.
        if ! out=$(gitleaks $mode --redact --no-banner --no-color . 2>&1); then
            echo "FAIL: gitleaks ($mode) found possible secrets:"
            echo "$out"
            fail=1
        fi
    done
else
    echo "skipped: gitleaks is not installed (brew install gitleaks)"
fi

if [ "$fail" -ne 0 ]; then
    echo "check.sh: FAILED"
    exit 1
fi
echo "check.sh: OK"
