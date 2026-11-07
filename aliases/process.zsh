# Process aliases

# aliases to view processes according to various sorting and filtering options

## get top ten memory intensive processes
#alias psmem10='command ps c -ewo user,pid,pcpu,pmem,cmd --sort=-%mem | head -11'
# for mac:
alias psmem10='ps auxww | head -n 1; ps auxww | sort -nrk 4 | head -n 10'

## get top 10 cpu intensive processes
#alias pscpu='ps auxf | sort -nr -k 3'
# for mac:
alias pscpu10='ps auxww | head -n 1; ps auxww | sort -nrk 3 | head -n 10'


# search processes for given argument
# e.g pssearch finder
alias pssearch="ps aux | grep -v grep | grep -i -e VSZ -e"

# use bottom as crates installed the app as btm
# Guarded with a real `_has` check, so the alias exists only when `btm` is installed.
if _has btm; then
    alias bottom='btm --basic --celsius --current_usage --group_processes --cpu_left_legend --enable_gpu'
fi
# if [ "_has btm" ]; then
#     alias bottom="btm --basic --celsius --current_usage --group_processes --cpu_left_legend --enable_gpu"
# fi

# use htop as replacement for top
if _has htop; then
    alias top='htop'
fi
# if [ "_has htop" ]; then
#     alias top='htop'
# fi


