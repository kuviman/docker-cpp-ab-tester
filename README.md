# Как запускать пример

1. Выполните `docker build -t cpp-ab-tester .` в директории docker
1. Затем запустите `r.bat`/`r.sh` с двумя аргументами - решение из `./incomes`, и номер подзадачи. Например `./r.sh ok "1"`
1. Посмотрите в `outcome/result.json`

# Требования к контейнеру

Докер-контейнер запускается с 3 аргументами. Все аргументы - пути до файлов. Они относительные (при запуске контейнера устанавливается `--workdir` в примонтированную директорию с нужными файлами):

- `$1` - в файле содержится имя(номер) подзадачи. Сами тесты встроены в контейнер.
- `$2` - путь до файла-решения участника
- `$3` - путь до авторского решения (если вы хотите их использовать для сравнения авторского и пользовательского решения, можно игнорировать)

Вывод идет в json файл по пути `$RESULT_JSON_FILE`. У него всегда три поля: 

1. verdict=COMPILATION_ERROR|OK,
1. points=вещественное число, записанное обычным образом, не превосходит 10000, не более 3 знаков после десятичной точки,
1. comment=человекочитаемый комментарий (протокол), который будет доступен участнику

### Типичное поведение контейнера:

1. Если есть фаза компиляции отосланного решения, то попробовать сделать его. Если не получилось, то вернуть такой result.json:
`{"verdict":"COMPILATION_ERROR","points":0,"comment":"/income/program.cpp: In function 'int main()':\n/income/program.cpp:9:13: error: expected ';' before '}' token\n    9 |     return 0\n      |             ^\n      |             ;\n   10 | }\n      | ~            "}`

1. Если фазы компиляции нет, то перейти к тестированию на последовательности тестов выбранной подзадачи (называть их test cases).

1. Запускать на каждом из них, вести протокол, помнить, что он будет доступен участнику.

1. Завершиться вот с таким примерно result.json:
`{"verdict":"OK","points":3,"comment":"Test case 1: Passed\nTest case 2: Passed\nTest case 3: Passed\n"}`

1. Со стороны Codeforces ограничения в плане времени/памяти будут только на весь запуск контейнера, поэтому если нужны отдельные ограничения на тест кейзы,
то имплементить их как-то внутри контейнера

Суммарно comment не делать длиннее 1KB в любом случае при любом исходе


