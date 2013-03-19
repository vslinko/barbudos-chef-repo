```shell
$ bundle install
$ librarian-chef install
$ knife cookbook upload -ao cookbooks
$ knife role from file roles/*
$ knife bootstrap bar-barbudos.ru -N bar-barbudos.ru -x root -r "role[barbudos_application]"
```
