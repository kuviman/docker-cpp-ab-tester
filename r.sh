mkdir outcome
docker run --rm -v $(pwd)/incomes/$1:/income -v $(pwd)/outcome:/outcome cpp-ab-tester
