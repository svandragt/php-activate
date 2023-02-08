# php-activate
Switch apt installed PHP versions within a local shell, without sudo (update-alternatives), without compiling my own PHP (phpenv). without custom PHP versions (php-versions).


## Install

```shell
$ mkdir -p $HOME/opt/php-activate # or your place of choice
$ cd !$
$ curl -# -L https://github.com/svandragt/php-activate/tarball/main | tar -xz --strip 1
```

## Setup

Add the following line to your shell rc script:

```
source $HOME/opt/php-activate/php-activate.sh # or your place of choice
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
Activated: /usr/bin/php8.2
PHP 8.2.2 (cli) (built: Feb  7 2023 11:28:53) (NTS)
...

# Deactivate (or use a different shell)
$ php-activate
Deactivated: /usr/bin/php8.2
PHP 8.1.15 (cli) (built: Feb  7 2023 11:31:36) (NTS)
...
```

## Other software

### Direnv

Add the following to `~/.direnvrc`:

```
# Usage: use php <version>
#
# Loads the specified php version into the environent
#
use_php() {
  source $HOME/opt/php-activate/php-activate.sh
  php-activate $1
  layout php
}
```

then add the following to the project's `.envrc`:
```
use php 8.2
```


## Credits

Thanks to [wilmoore for php-version](https://github.com/wilmoore/php-version) which inspired this idea.
