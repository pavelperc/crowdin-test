# Crowdin-test

Этот репозиторий демонстрирует разные способы загрузки строк в crowdin из Android проекта.

В crowdin созданы два проекта:

* [bookmate-test](https://crowdin.com/project/bookmate-test):
  * Исходники на русском (`ru`)
  * Переводы на `en`, `uk`
* [bookmate-test-en](https://crowdin.com/project/bookmate-test-en):
  * Исходники на английском (`en`)
  * Перевод на `fr`

## Требования

* Исходные строки приходят на русском.
* При поступлении перевода с русского на английский, необходимо делать sync: отправлять переведённую строку в английский проект.
* Должна быть возможность собрать корректную QA сборку из ветки.

# Способы решения

В обоих способах в `values` лежит русский язык. Посчитал, что так будет удобнее. (Хочу ещё раз обсудить.)

## Способ 1
(Ветка `master`)

* Все строки вместе с исходниками хранятся в crowdin.
* Отправка строк происходит вручную.
* Загрузка строк запускается при каждой сборке, либо вручную.
* При отправке проверяется, что строки, добавленные другими разработчиками не перезапишутся. (Используется `diff`)
* Sync происходит на ci по таймеру.

## Способ 2
todo

* Исходники `ru` хранятся в гите и в crowdin, переводы хранятся только в crowdin.
* Отправка строк происходит на ci после пуша, если в названии ветки есть фраза `[loc]`.
* При отправке используются ветки из crowdin.
* При мёрдже веток в crowdin-е, от него приходит пулл реквест в гитхаб.
* ~~Синк тоже происходит на ci при пуше. Ветки в русском проекте дублируются в ветки в английском проекте.~~
* При мёрже пр от crowdin-а, происходит синк в английский проект.

**UPD**
Попробовали создать ветки в crowdin. Обнаружили следующие проблемы:
* crowdin делает для каждой ветки дубликат всех строк. Это выглядит странно для переводчиков.
* Мы не нашли кнопку как смёржить ветки.
* Интеграция с гитхабом пока зависла, тоже не разобрались.

