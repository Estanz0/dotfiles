autoload -Uz is-at-least

# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
    local ref
    ref=$(git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?
    if [[ $ret != 0 ]]; then
        [[ $ret == 128 ]] && return  # no git repo.
        ref=$(git rev-parse --short HEAD 2> /dev/null) || return
    fi
    echo ${ref#refs/heads/}
}

# Outputs the name of the current user
# Usage example: $(git_current_user_name)
function git_current_user_name() {
    __git_prompt_git config user.name 2>/dev/null
}

# Outputs the email of the current user
# Usage example: $(git_current_user_email)
function git_current_user_email() {
    __git_prompt_git config user.email 2>/dev/null
}

# Output the name of the root directory of the git repository
# Usage example: $(git_repo_name)
function git_repo_name() {
    local repo_path
    if repo_path="$(git rev-parse --show-toplevel 2>/dev/null)" && [[ -n "$repo_path" ]]; then
        echo ${repo_path:t}
    fi
}

# The name of the current branch
# Back-compatibility wrapper for when this function was defined here in
# the plugin, before being pulled in to core lib/git.zsh as git_current_branch()
# to fix the core -> git plugin dependency.
function current_branch() {
    git_current_branch
}

# Check for develop and similarly named branches
function git_develop_branch() {
    command git rev-parse --git-dir &>/dev/null || return
    local branch
    for branch in dev devel develop development; do
        if command git show-ref -q --verify refs/heads/$branch; then
            echo $branch
            return 0
        fi
    done

    echo develop
    return 1
}

# Check if main exists and use instead of master
function git_main_branch() {
    command git rev-parse --git-dir &>/dev/null || return
    local ref
    for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,master}; do
        if command git show-ref -q --verify $ref; then
            echo ${ref:t}
            return 0
        fi
    done

    # If no main branch was found, fall back to master but return error
    echo master
    return 1
}
