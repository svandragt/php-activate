#!/usr/bin/env bash

function php-activate {
    if [ -n "$1" ]
    then
        local VERSIONS
        VERSIONS=$(update-alternatives --query php | grep Alternative | cut -d ' ' -f2 )
        if echo "$VERSIONS" | grep -q "$1"
        then
            PHP_PICKED=$(echo "$VERSIONS" | sort | grep "$1" | head -n 1)
            export PHP_PICKED
            echo "Activated $PHP_PICKED"
        else
            echo "Error: No matching PHP version found. Use one of the following:"
            echo "$VERSIONS"
            return
        fi
    else
        echo "Deactivated $PHP_PICKED"
        unset -f php 
        hash -r
        return
    fi
    function php {
        $PHP_PICKED "$@"
    }
    php --version | grep built
    hash -r
}

php-activate "$1"
