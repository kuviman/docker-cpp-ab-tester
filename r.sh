docker build -t cpp-ab-tester docker
mkdir -p outcome
echo "$2" > test.txt
docker run --rm \
    -v $(pwd)/test.txt:/income/test.txt:ro \
    -v $(pwd)/incomes/$1.cpp:/income/program.cpp:ro \
    -v $(pwd)/incomes/ok.cpp:/income/judge_solution.cpp:ro \
    -v $(pwd)/outcome:/outcome \
    --env RESULT_JSON_FILE=/outcome/result.json \
    --workdir /income \
    cpp-ab-tester test.txt program.cpp judge_solution.cpp
