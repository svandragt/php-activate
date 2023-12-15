# php-activate
Switch system installed PHP versions within a local shell session.

Made for those working with multiple projects using a variety of PHP versions, this script will automatically switch to the correct PHP version after `cd`ing into the project folder. It does not require sudo, so even works in IDEs.

* No sudo is required to switch versions (in contrast to update-alternatives), so it works in IDE terminals.
* No need to compile PHP (in contrast to phpenv), just use your package manager. 
* No need for manual PHP installs (in contrast to php-versions), system installed php versions are detected.

## Requirements

A bunch of PHP versions installed named `/usr/bin/php*`.

## Install

```shell
$ mkdir -p $HOME/opt/php-activate # or your place of choice
$ cd !$
# Downloads a tarball from a GitHub repository, extracts its contents, and then strips the first directory level:
$ curl -# -L https://github.com/svandragt/php-activate/tarball/main | tar -xz --strip 1
```

## Setup

Add the following line to your shell rc script (replace 8.2 with your default php version):

```
source $HOME/opt/php-activate/php-activate.sh 8.2
```


## Run examples

```shell
# Activate a non-existing version
$ php-activate 9
Error: No matching PHP version found. Use one of the following:
/usr/bin/php8.0
/usr/bin/php8.1
/usr/bin/php8.2

# System version
$ php --version
PHP 8.1.15 (cli) (built: Feb  7 2023 11:31:36) (NTS)
Copyright (c) The PHP Group
Zend Engine v4.1.15, Copyright (c) Zend Technologies
    with Zend OPcache v8.1.15, Copyright (c), by Zend Technologies
    
# Activate existing version
$ php-activate 8.2
Activated /usr/bin/php8.2
PHP 8.2.2 (cli) (built: Feb  7 2023 11:28:53) (NTS)
...

# Deactivate (or use a different shell)
$ php-activate
Deactivated /usr/bin/php8.2
PHP 8.1.15 (cli) (built: Feb  7 2023 11:31:36) (NTS)
...
```

## Integrations

### Direnv

Add the following to `~/.direnvrc`:

```
# Usage: use php <version>
#
# Loads the specified php version into the environent
#
use_php() {
  source $HOME/opt/php-activate/php-activate.sh $1
  layout php
}
```

then add the following to the project's `.envrc`:
```
use php 8.2
```
Now you can simply change into the project directory:

```shell
$ cd myproject
direnv: loading ~/dev/myproject/.envrc
direnv: using php 8.2
Activated /usr/bin/php8.2
PHP 8.2.2 (cli) (built: Feb  7 2023 11:28:53) (NTS)
direnv: export [...] ~PHP_PICKED
```

## Alternatives

Please consider [asdf](https://asdf-vm.com/) with the [PHP plugin](https://github.com/asdf-community/asdf-php).


## Credits

Thanks to [wilmoore for php-version](https://github.com/wilmoore/php-version) which inspired this idea.
