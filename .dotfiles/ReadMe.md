# Managing Dot Files

## How to setup configuration from repo on a new machine

1. add alias to your shell config file:&nbsp;
`alias dot="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"`
2. clone your repo to your local machine:&nbsp;
`git clone --bare git@github.com:AnshumanSanghvi/dotfiles.git $HOME/.dotfiles`
3. source your shell config file: e.g `source ~/.zsh/.zshrc`

## How to set up your dot file management

initialize a bare git repo on your home directory:&nbsp;
`git init --bare $HOME/.dotfiles`

setup alias for your dot files repo:&nbsp;
`alias dot="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"`

hide all untracked files when `status` command is called:&nbsp;
`dot config status.showUntrackedFiles no`

create git branches as profiles:&nbsp;
e.g work branch for work machine, aws branch for aws ec2 machines etc.

---

## Configuration

### ZSH

add the following line to `/etc/zsh/zshenv`: `source ~/.zsh/.zshenv`

## References

- [Atlassian: Using git bare repo for dot files](https://www.atlassian.com/git/tutorials/dotfiles)
- [Setting Up development machine part 3](https://engineering.kalkayan.io/posts/setting-up-a-development-machine-part-3/)
