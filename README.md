# News application

Приложение, написанное на flutter, позволяющее просматривать новости, полученные из newsAPI.

## Описание

Приложение представляет собой ленту новостей по 2 категориям (выбор категории реальзован через tabBar) и страницу каждой новости, на которую можно попасть, нажав по ее карточке в ленте.

## Работа с данными

Данные получаются из newsAPI, обрабатываются при помощи json_serializable, после чего отображаются на экране пользователя

## Запуск

```terminal
cd flutter_app
```

```terminal
flutter pub get
```

```terminal
dart run build_runner build 
```

```terminal
flutter run
```

## Скриншоты

### Лента (основной экран):

![Лента](https://github.com/ArsPro13/flutter-hw-1/blob/main/screenshots/main_screen.jpg)

### Страница новости:

![Страница новости](https://github.com/ArsPro13/flutter-hw-1/blob/main/screenshots/article_screen.jpg)
