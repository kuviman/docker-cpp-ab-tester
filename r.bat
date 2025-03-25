docker build -t cpp-ab-tester docker
mkdir outcome
echo "%2" > test.txt
docker run --rm ^
    -v "%cd%/test.txt:/income/test.txt:ro" ^
    -v "%cd%/incomes/%1.cpp:/income/program.cpp:ro" ^
    -v "%cd%/incomes/ok.cpp:/income/judge_solution.cpp:ro" ^
    -v "%cd%/outcome:/outcome" ^
    --env RESULT_JSON_FILE=/outcome/result.json ^
    --workdir /income ^
    cpp-ab-tester test.txt program.cpp judge_solution.cpp
