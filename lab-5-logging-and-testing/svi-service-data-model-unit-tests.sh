#!/bin/bash

ansible-playbook -i ../lab-3-create-service-data-model/data-models/hosts svi-service-data-model-testing.yml > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo ".. Initial test failed. Aborting."
    exit 1
fi
echo ".. Initial test OK. Proceeding."

exitstatus=0
for data_model_test in tests/nodes-svi-service-invalid-*.yml; do
    echo "Running scenario $data_model_test"
    ansible-playbook -i ../lab-3-create-service-data-model/data-models/hosts svi-service-data-model-testing.yml -e data_model_path=$data_model_test > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo ".. Failed as expected."
    else
        echo ">>> DID NOT fail."
        exitstatus=1
    fi
done

if [ $exitstatus -ne 0 ]; then
    echo "Test suite failed"
fi

exit $exitstatus