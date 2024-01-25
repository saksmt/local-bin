# k8sps1

Simple script to display current k8s context and namespace.

## Installation

Call `k8sps1 install bash`/`k8sps1 install zsh` and execute script from output.

## Usage

To show k8sps1 in current terminal session call `k8sps1 show`, 
to hide - `k8sps1 hide`, to forcefully hide (ignoring configured 
behaviour) - `k8sps1 hide --force`

There's also an option to show/hide across all terminal sessions - just add `--global` option:
```
k8sps1 show --global
k8sps1 hide --global
k8sps1 hide --global --force
```

Precedence logic is following: show if and only if nothing is forcefully hiding and at least case 
tells to show (current session, global, configured)

## Configuration

All configuration is done through `/usr/local/etc/k8sps1` config file. Format - bash.
You can see default values, description and possible configuration options in
`/usr/local/etc/default/k8sps1`

There are two main ways to configure automatic display: by regex on current working directory and
by locating file in current working directory tree.

### Regex on pwd

You can use regular expression on current working directory full path to determine whether
PS1 should be shown or not. Configuration option - `ENABLING_PWD_REGEXP`, it accepts PCRE style
regular expression without ignoring case.

### Searching file in tree

Let's consider following file tree:
```
📁 /home/hamster
  ├ 📁 code
  │ ├ 📁 work
  │ │ ├ 📁 projectA
  │ │ │ ├ 📁 src
  │ │ │ │ ╰ 📁 main
  │ │ │ │   ...
  │ │ │ ├ 📄 build.sbt
  │ │ │ ╰ 📄 .k8sproj
  │ │ ╰ 📁 projectB
  │ │   ├ 📁 src
  │ │   │ ╰ 📁 main
  │ │   │   ...
  │ │   ├ 📄 pom.xml
  │ │   ╰ 📄 .k8sproj
  │ ╰ 📁 opensource
  ╰ 📁 Downloads
```

And imagine that out current working directory is `/home/hamster/code/work/projectA/src/main`. 
Our criteria for whether PS1 is needed is that we are in a project that has `.k8sproj` file, so
we want to search for `.k8sproj` in current directory and all the parents. To do so we can
set `ENABLING_LOCAL_MARKER_FILE` to `.k8sproj` (`ENABLING_LOCAL_MARKER_FILE=.k8sproj`).

Now imagine that we are in `/home/hamster/Downloads/music/Attila/Albums/2011/Outlawed`. We don't want to wait for eternity
on after each command when there's definitely no `.k8sproj` in sight. There are two options to limit
how long would traversal go:
 - `LOCAL_MARKER_SEARCH_CUTOFF_PWD` - until which path should we go upwards, default `$HOME`
 - `LOCAL_MARKER_SEARCH_CUTOFF_TIMES` - how many directories should we list, default `4`

Remember - the looser the cutoffs the longer the search will be!

### Customization

There are two ways to customize: behavior and view.

#### View

You can customize how context and namespace are printed by defining a function (or even a script)
and storing its name in `DECORATE_CONTEXT_FN`.

Let's say you want to highlight context name if it starts with `PROD_` prefix stripping it, and you
want for ps1 to look like `[$context // $namespace]`
You'll need to define function:
```shell
function decorate() {
    red=$(echo -ne "\033[31m")
    clr=$(echo -ne "\033[0m")
    
    context="${1}"
    namespace="${2}"
    if [[ "${1}" == PROD_* ]]; then
        context="${red}${context//PROD_}${clr}"
    fi
    echo "[${context} // ${namespace}]"
}
DECORATE_CONTEXT_FN=decorate
```

You can do pretty much anything only limited by your fantasy by redefining this function.

### Behavior

Imagine you're using microk8s for some reason and for some reason you don't have `kubectl` in your `PATH`,
there's still a way to make k8sps1 work (as for saving you - that's a whole different story.)
You can define custom function retrieving context and namespace names and pass its name to `GET_CURRENT_CONTEXT_FN`:
```shell
function contextFromMicrok8s() {
  echo "$(microk8s kubectl config current-context) $(microk8s kubectl config view --minify --output 'jsonpath={..namespace}')"
}
GET_CURRENT_CONTEXT_FN=contextFromMicrok8s
```

Note that while you can go absolutely crazy with this you still should respect specification and not ignore `KUBECONFIG` and
default path of `~/.kube/config`, otherwise cache will not work correctly.

### Cache

`kubectl` may sometimes be brutally slow, for such cases there's caching in place.
Cache invalidates automatically when kube config is modified or when it expires by ttl.
Note that `k8sps1` follows convention recognized by standard `kubectl`, meaning:
 - it looks for config in `KUBECONFIG` env var (multiple paths separated by colon are also supported)
 - if no `KUBECONFIG` is defined it looks at `.kube/config`
 - it assumes that namespace and context can not be changed without changing config

So if you're using something that ignores specification cache may not work properly.

You can control ttl by modifying `MAX_CACHE_TTL_SECONDS` config parameter, by default it is 24 hours.

You can also forcefully invalidate caches at any moment by calling `k8sps1 invalidate-cache`

### Misc parameters

There's a bunch more config parameters for temporary and internal use, you can inspect them in `/usr/local/etc/default/k8sps1`
