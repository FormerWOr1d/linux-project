g++ cpp2.cpp -o cpp2
g++ main.cpp -o main

MIN=${1:-1}
MAX=${2:-100}
COUNT=${3:-10}

./cpp2 --min "$MIN" --max "$MAX" --count "$COUNT" | ./main | cowsay -f dragon-and-cow
