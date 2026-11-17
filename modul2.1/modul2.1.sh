#!/bin/bash
echo "markdown"
echo "Папка $1"

rm -f *.deb
rm -rf my_data my_META

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

\`\`\`bash
$(cat my_META/preinst 2>/dev/null || echo "(файл отсутствует)")
\`\`\`

## Файл Postinst

\`\`\`bash
$(cat my_META/postinst 2>/dev/null || echo "(файл отсутствует)")
\`\`\`

## Файл Prerm

\`\`\`bash
$(cat my_META/prerm 2>/dev/null || echo "(файл отсутствует)")
\`\`\`

## Файл Postrm

\`\`\`bash
$(cat my_META/postrm 2>/dev/null || echo "(файл отсутствует)")
\`\`\`
"
echo "$text">"MARKDOWN.md"
rm -rf "$file"
rm -rf my_data
rm -rf my_META
