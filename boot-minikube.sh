#!/usr/bin/env bash
# REQ: Homebrew
# NOTE: WARNING: The xhyve driver is now deprecated; please consider switching
#       to the hyperkit driver, which is intended to replace the xhyve driver.
set -x

function prep_macOS() {
    if [[ ! "$(type -P docker-machine-driver-xhyve)" ]]; then
        brew info docker-machine-driver-xhyve
        sudo chown root:wheel "$(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve"
        sudo chmod u+s "$(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve"
    fi
}

#function prep_Linux() {
#    #function_body
#}


# Use the proper hypervisor for the platform
case "$(uname)" in
    'Darwin')
        prep_macOS
        minikube start --vm-driver=xhyve
        ;;
    'GNU/Linux')
        prep_Linux
        ;;
esac


