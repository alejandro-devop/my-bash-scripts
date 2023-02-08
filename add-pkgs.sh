#!/bin/bash

project="${XAVIER_PROJECT_DIR}"
package_vendor="@alejandro.dev"
packages_dir="${RN_PKGS_DIR}"
packages=("rn-themizer" "rn-navigation-wrapper" "rn-components" "rn-async-persistance" "rn-rest-client")

total_packages=$(wml ls | wc -l)
# Need to remove a \n and the last to be exact
total_packages=`expr $total_packages - 2`

if ((total_packages > 0)); then
    echo "|_ Cleaning packages..."
    for index in $(eval echo "{0..$total_packages}")
    do
        wml rm $index > /dev/null 2>&1
    done
    echo "|  |_ [Ok]"
    echo "|  "
else
    echo "No packages to be removed.."
fi

echo "|_ Moving to ${project}"
echo "|  |_ Adding dependencies: "

for item in "${packages[@]}"
do
    echo "|      |-> Adding package: ${item}"
    printf 'y\ny' | wml add "${packages_dir}/${item}" "${project}/node_modules/${package_vendor}/${item}" > /dev/null 2>&1
    echo "|      |   |_ [OK]"
    echo "|      |"
done

wml ls

echo "Starting wml"
wml start
