# k8s-interactive-choose

Script based on `fzf` to let you interactively switch between namespaces and contexts of k8s

## Prerequisites

You need to have [`fzf`](https://github.com/junegunn/fzf) available from your `PATH`

### (Non-comprehensive) List of GNU coreutils commands used

 - cut
 - head
 - mkdir
 - readlink
 - `shopt -s extglob`
 - sort
 - stat
 - tail
 - tr
 - xargs

#### What does it mean?

It means that it will work virtually on any linux with fzf and bash installed but will possibly fail on macOS and BSD (untested). To try and make it work
on macOS and BSD you can install GNU coreutils and make it so that script can access it with unprefixed names, for example, on macOS you need to follow
[this](https://apple.stackexchange.com/a/69332) answer on stackexchange and place `export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}""`
into `k8s-interactive-choose` configuration file and it *may* work. All bugs related to incompatibility between BSD/macOS coreutils and GNU ones
will be ignored.

## Usage

 - `k8s-interactive-choose namespace` - to choose namespace
 - `k8s-interactive-choose context` - to choose context
 - `k8s-interactive-choose refresh` - to drop cached info about available namespaces and contexts, useful when there is 
   new namespace created in k8s or cache somehow failed to refresh automatically 

You can also add corresponding aliases for those commands in your favorite shell

## Configuration

All configuration is done through `/usr/local/etc/k8s-interactive-choose` config file. Format - bash.
You can see default values, description and possible configuration options in
`/usr/local/etc/default/k8s-interactive-choose`. You can also place `PATH` overrides there to 
try and make this script work on macOS or BSD.

### Customization

Refer to default configuration (at `/usr/local/etc/default/k8s-interactive-choose`) for customization options (there are plenty)

### Cache

`kubectl` may sometimes be brutally slow, for such cases there's caching in place.
Cache invalidates automatically when kube config is modified or when it expires by ttl.
Note that `k8s-interactive-choose` follows convention recognized by standard `kubectl`, meaning:
 - it looks for config in `KUBECONFIG` env var (multiple paths separated by colon are also supported)
 - if no `KUBECONFIG` is defined it looks at `.kube/config`
 - it assumes that namespace and context can not be changed without changing config

So if you're using something that ignores specification cache may not work properly.

You can control ttl by modifying `CONTEXT_CACHE_TTL_SECONDS` and `NAMESPACE_CACHE_TTL_SECONDS` config parameters, by default they are 24 hours.

You can also forcefully invalidate caches at any moment by calling `k8s-interactive-choose refresh`
