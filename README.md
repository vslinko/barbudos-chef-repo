```shell
$ bundle install
$ librarian-chef install
$ knife cookbook upload -ao cookbooks
$ knife role from file roles/*
$ knife bootstrap bar-barbudos.ru -N bar-barbudos.ru -x root -r "role[barbudos_application]"
```

## Конфигурирование

```shell
$ knife data bag create barbudos application
```

Во время запуска комманды откроется текстовый редактор для ввода настроек.
Настройки приложения должны быть в формате JSON и содержать следующие поля:

```json
{
  "id": "application",
  "email_service": "",
  "email_user": "",
  "email_password": "",
  "sms24x7_username": "",
  "sms24x7_password": "",
  "sms24x7_callback": "",
  "notification_email": "",
  "notification_phones": []
}
```
