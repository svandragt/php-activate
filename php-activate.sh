#!/usr/bin/env bash

function php-activate {
    if ! [ -z "$1" ]
    then
        local VERSIONS=$(update-alternatives --query php | grep Alternative | cut -d ' ' -f2 )
        if echo $VERSIONS | grep -q "$1"
        then
            export PHP_PICKED=$(echo "$VERSIONS" | sort | grep "$1" | head -n 1)
            function php {
                $PHP_PICKED $@
            }
            echo "Activated: $PHP_PICKED"
            php --version | grep built
            hash -r
        else
            echo "Error: No matching PHP version found. Use one of the following:"
            echo "$VERSIONS"
        fi
        return
    fi

    if ! [ -z $PHP_PICKED ]
    then    
        echo "Deactivated: $PHP_PICKED"
        unset PHP_PICKED
        unset -f php
        php --version | grep built
        hash -r
        return
    fi
}
