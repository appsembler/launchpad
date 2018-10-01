CONFIG=$HOME/wt-setup.txt
if [ ! -f $CONFIG ] ; then 
	~/examples/helpers/wt-setup.sh
	source $CONFIG
else
	source $CONFIG
fi
echo -e "\nGenerating the list of commands... (please ensure you edit the .json files before submitting the call, and replace <test_definition_id> and <test_definition_execution_id> with the values returned but the API calls)"
echo -e "\nhttp --session world-tour --auth-type=edgegrid -a atc: POST :/test-management/v1/test-definitions < ~/examples/test-center/create-test-definition.json"
echo -e "\nhttp --session world-tour --auth-type=edgegrid -a atc: POST :/test-management/v1/test-definitions/<test_definition_id>/test-cases < ~/examples/test-center/create-test-case.json"
echo -e "\nhttp --session world-tour --auth-type=edgegrid -a atc: POST :/test-management/v1/test-runs < ~/examples/test-center/test-run-obj.json"
echo -e "\nhttp --session world-tour --auth-type=edgegrid -a atc: GET :/test-management/v1/test-definition-executions/<test_definition_execution_id>"
echo -e "\nhttp --session world-tour --auth-type=edgegrid -a atc: GET :/test-management/v1/test-definition-executions/<test_definition_execution_id>/differences"
echo -e "\nhttp --session world-tour --auth-type=edgegrid -a atc: PUT :/test-management/v1/test-definition-executions/<test_definition_execution_id>/differences < ~/examples/test-center/differences.json"
