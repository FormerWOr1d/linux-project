echo "Вызвана программа: $0"
echo "Первый параметр: $1"
echo""

my_var="Первый: $1"

echo "Значение my_var = ${my_var}"

new_folder_name="project_$1"
project_path="$HOME/projects/test/$new_folder_name"

if [ -d "$project_path" ]
then
    echo "Такой репо уже есть"
    exit 1
fi

mkdir -p "$project_path"
cd "$project_path" || exit 1

git init
touch README.md
nano README.md
git add README.md
git commit -a -m "Первый комм"

echo -e "$textFromPastTask" >> "README.md"
echo -e "$text" >> "README.md"

key_path="$HOME/.ssh/id_ed25519_$1"
ssh-keygen -t ed25519 -f "$key_path" -N "" -q

echo "
Host github-$1
    HostName github.com
    User git
    IdentityFile $key_path" >> "$HOME/.ssh/config"

echo "https://github.com/new"
echo "Ваш ключ:"
cat "$key_path.pub"

GITHUB_USER="FormerW0r1d"

GITHUB_TOKEN="ghp_aAnAo34HGcCN6vxpVw4TSfAHpbengf1mw7q9"



echo "Создаем репозиторий на GitHub"
curl -s -X POST -u "$GITHUB_USER:$GITHUB_TOKEN" \
    https://api.github.com/user/repos \
    -d "{\"name\":\"$1\"}" > repo.json

SSH_URL=$(jq ".ssh_url" -r repo.json)
echo "Добавляем SSH-ключ в репозиторий..."
KEY=$(cat "$key_path.pub")
curl -u "$GITHUB_USER:$GITHUB_TOKEN" -X POST \
    https://api.github.com/repos/$GITHUB_USER/$1/keys \
    -d "{\"title\":\"deploy-key-$1\",\"key\":\"$KEY\",\"read_only\":false}"
echo "Привязываем remote и отправляем файлы..."
SAFE_URL=$(echo "$SSH_URL" | sed "s/github.com/github-$1/")

git remote add origin "$SAFE_URL"
git branch -M main
git push -u origin main
