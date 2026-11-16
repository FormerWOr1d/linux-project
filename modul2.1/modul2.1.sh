echo "markdown"
echo "Папка $1"
apt download $1

file=$(ls $1*.deb)

mkdir my_data my_META
dpkg -x $file my_data
dpkg -e $file my_META

text="
$(figlet -f block $1 | sed 's/^/    /')

$(apt show $1 2>/dev/null | sed 's/$/  /' | sed -E 's/(^\b.+?:) /**\1** /g')

# Структура пакета

$(tree -L 3  my_data | sed 's/^/    /')

## Файл Preinst

$(sed 's/^/    /' my_META/preinst)

## Файл Postinst

$(sed 's/^/    /' my_META/postinst)

## Файл Prerm

$(sed 's/^/    /' my_META/prerm)

## Файл Postrm

$(sed 's/^/    /' my_META/postrm)
"
echo "$text">"MARKDOWN.md"
rm -rf "$file"
rm -rf my_data
rm -rf my_META
