currupt=$(sudo find /var/lib/docker/containers/ -name *-json.log -exec bash -c 'jq '.' {} > /dev/null 2>&1 || echo "{}"' \;)

for i in ${currupt};
do
    echo "${i}"
    sudo rm -rf "${i}"
done
# echo "${currupt}"