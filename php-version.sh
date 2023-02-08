#!/usr/bin/env bash

function php-activator {
    if ! [ -z "$1" ]
    then
        local VERSIONS=$(update-alternatives --query php | grep Alternative | cut -d ' ' -f2 )
        if echo $VERSIONS | grep -q "$1"
        then
            export PHP_PICKED=$(echo $VERSIONS | sort | grep "$1" | head -n 1)
            function php {
                $PHP_PICKED $@
            }
            echo "Activated: $PHP_PICKED"
        fi
        php --version
        hash -r
        return
    fi

    if ! [ -z $PHP_PICKED ]
    then    
        echo "Deactivated: $PHP_PICKED"
        unset PHP_PICKED
        unset -f php
    fi
    php --version
    hash -r
}
