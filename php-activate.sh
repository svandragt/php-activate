#!/usr/bin/env bash

function php-activate {
    quiet=false
    version=

    # Check for the --quiet or -q option
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --quiet | -q )
                quiet=true
                shift
                ;;
            * )
                version="$1"
                shift
                ;;
        esac
    done

    if [ -n "$version" ]
    then
        local VERSIONS
        VERSIONS=$(update-alternatives --query php | grep Alternative | cut -d ' ' -f2 )
        if echo "$VERSIONS" | grep -q "$version"
        then
            PHP_PICKED=$(echo "$VERSIONS" | sort | grep "$version" | head -n 1)
            export PHP_PICKED
            if [ "$quiet" = false ]; then
                echo "Activated $PHP_PICKED"
            fi
        else
            echo "Error: No matching PHP version found. Use one of the following:"
            echo "$VERSIONS"
            return 1
        fi
    else
        if [ "$quiet" = false ]; then
            echo "Deactivated $PHP_PICKED"
        fi
        unset -f php 
        hash -r
        return
    fi
    function php {
        $PHP_PICKED "$@"
    }
    if [ "$quiet" = false ]; then
        php --version | grep built
    fi
    hash -r
}

php-activate "$@"
