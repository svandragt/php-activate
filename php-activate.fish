#!/usr/bin/env fish

function php-activate
    if not test -z $argv[1]
        set php_versions (update-alternatives --query php | grep Alternative | cut -d ' ' -f2)
        if string match "*$argv[1]" $php_versions
            set -xg PHP_PICKED (string match "*$argv[1]" $php_versions | head -n 1)
            function php
                $PHP_PICKED $argv
            end
            echo "Activated: $PHP_PICKED"
            php --version | grep built
        else
            echo "Error: No matching PHP version found. Use one of the following:"
            echo "$php_versions"
        end
        return
    end

    if not test -z $PHP_PICKED
        echo "Deactivated: $PHP_PICKED"
        set -e PHP_PICKED
        functions -e php
        php --version | grep built
        return
    end
end
