mkdir outcome
docker run --rm -v $(pwd)/income-$1:/income -v $(pwd)/outcome:/outcome cpp-ab-tester
