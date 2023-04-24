Тут я хотел бы описать аномалии обнаруженные в работе кластера, хостов
## 1 Вопрос
Изначально загрузка очень долгая в связи с тем что не может запустить следующие сервисы
![image](https://user-images.githubusercontent.com/122198710/233903857-5aa0c855-af79-4b67-9195-121f59937797.png)
![image](https://user-images.githubusercontent.com/122198710/233903896-5bf4540b-682d-4a61-9368-7b6a0f7868ea.png)
Хотелось бы победить данный затык чтобы перезагрузка хостов была быстрее.

## 2 Вопрос
на всех трех рабочих нодах висят сервисы не стратованные, хотел бы уточнить что это и как победаить чтобы их там не было

![image](https://user-images.githubusercontent.com/122198710/233904105-a0ca0d44-2ee8-4e3f-9297-52f2180ecc1c.png)
перезагрузка хоста не решает данную проблему
До перезагрузки:
![image](https://user-images.githubusercontent.com/122198710/233904164-a7a07c15-f66a-4f90-9604-7c3ab8c46fc4.png)
Во время загрузки:
![image](https://user-images.githubusercontent.com/122198710/233904188-53116262-5bb4-4847-90bd-0cde354dbaa6.png)
После перезагрузки:
![image](https://user-images.githubusercontent.com/122198710/233904211-f46a79b2-d55f-4059-bd64-a9bfe26200bc.png)


## 3 Вопрос
Еще из аномалий странное поведение swap, мне кажется раньше было по другому, сейчас использование swap 0 на всех серверах и на контейнерах управления
Это нормальная работа?
![image](https://user-images.githubusercontent.com/122198710/233904255-2f6d5b19-6fc0-4d29-bbd4-2b8f493a0c12.png)




## статус

[root@sng-rplat-01 ~]# for node_id in 01 02 03; do ssh root@sng-rplat-$node_id "hostname && "systemctl status systemd-journald.service systemd-journal-flush.service" && echo -e"; done

sng-rplat-01.sgc.oil.gas
● systemd-journald.service - Journal Service
   Loaded: loaded (/usr/lib/systemd/system/systemd-journald.service; static; vendor preset: disabled)
   Active: active (running) since Sat 2023-04-22 17:42:46 +05; 1 day 18h ago
     Docs: man:systemd-journald.service(8)
           man:journald.conf(5)
 Main PID: 11459 (systemd-journal)
   Status: "Processing requests..."
    Tasks: 1
   Memory: 3.7G
   CGroup: /system.slice/systemd-journald.service
           └─11459 /usr/lib/systemd/systemd-journald

Apr 22 17:42:46 sng-rplat-01.sgc.oil.gas systemd-journal[11459]: Runtime journal is using 8.0M (max allowed 300.0M, trying to leave 4.0G free of 251.6G available → current limit 300.0M).
Apr 22 17:42:46 sng-rplat-01.sgc.oil.gas systemd-journal[11459]: Journal started
Apr 22 17:42:46 sng-rplat-01.sgc.oil.gas systemd-journal[11459]: Permanent journal is using 3.9G (max allowed 4.0G, trying to leave 4.0G free of 24.6G available → current limit 4.0G).
Apr 22 17:42:46 sng-rplat-01.sgc.oil.gas systemd-journal[11459]: Time spent on flushing to /var is 36.773ms for 2669 entries.

● systemd-journal-flush.service - Flush Journal to Persistent Storage
   Loaded: loaded (/usr/lib/systemd/system/systemd-journal-flush.service; static; vendor preset: disabled)
   Active: active (exited) since Sat 2023-04-22 17:42:46 +05; 1 day 18h ago
     Docs: man:systemd-journald.service(8)
           man:journald.conf(5)
 Main PID: 11466 (code=exited, status=0/SUCCESS)
    Tasks: 0
   Memory: 0B
   CGroup: /system.slice/systemd-journal-flush.service

Apr 22 17:42:46 sng-rplat-01.sgc.oil.gas systemd[1]: Started Flush Journal to Persistent Storage.

sng-rplat-02.sgc.oil.gas
● systemd-journald.service - Journal Service
   Loaded: loaded (/usr/lib/systemd/system/systemd-journald.service; static; vendor preset: disabled)
   Active: active (running) since Sat 2023-04-22 17:57:52 +05; 1 day 18h ago
     Docs: man:systemd-journald.service(8)
           man:journald.conf(5)
 Main PID: 11697 (systemd-journal)
   Status: "Processing requests..."
    Tasks: 1
   Memory: 3.8G
   CGroup: /system.slice/systemd-journald.service
           └─11697 /usr/lib/systemd/systemd-journald

Apr 22 17:57:52 sng-rplat-02.sgc.oil.gas systemd-journal[11697]: Runtime journal is using 8.0M (max allowed 300.0M, trying to leave 4.0G free of 251.6G available → current limit 300.0M).
Apr 22 17:57:52 sng-rplat-02.sgc.oil.gas systemd-journal[11697]: Journal started
Apr 22 17:57:52 sng-rplat-02.sgc.oil.gas systemd-journal[11697]: Permanent journal is using 4.0G (max allowed 4.0G, trying to leave 4.0G free of 32.4G available → current limit 4.0G).
Apr 22 17:57:52 sng-rplat-02.sgc.oil.gas systemd-journal[11697]: Time spent on flushing to /var is 35.434ms for 2675 entries.
Apr 22 17:58:33 sng-rplat-02.sgc.oil.gas systemd-journal[11697]: Suppressed 85 messages from /

● systemd-journal-flush.service - Flush Journal to Persistent Storage
   Loaded: loaded (/usr/lib/systemd/system/systemd-journal-flush.service; static; vendor preset: disabled)
   Active: active (exited) since Sat 2023-04-22 17:57:52 +05; 1 day 18h ago
     Docs: man:systemd-journald.service(8)
           man:journald.conf(5)
 Main PID: 11706 (code=exited, status=0/SUCCESS)
    Tasks: 0
   Memory: 0B
   CGroup: /system.slice/systemd-journal-flush.service

Apr 22 17:57:52 sng-rplat-02.sgc.oil.gas systemd[1]: Started Flush Journal to Persistent Storage.

sng-rplat-03.sgc.oil.gas
● systemd-journald.service - Journal Service
   Loaded: loaded (/usr/lib/systemd/system/systemd-journald.service; static; vendor preset: disabled)
   Active: active (running) since Sat 2023-04-22 18:04:35 +05; 1 day 18h ago
     Docs: man:systemd-journald.service(8)
           man:journald.conf(5)
 Main PID: 11482 (systemd-journal)
   Status: "Processing requests..."
    Tasks: 1
   Memory: 3.7G
   CGroup: /system.slice/systemd-journald.service
           └─11482 /usr/lib/systemd/systemd-journald

Apr 22 18:04:35 sng-rplat-03.sgc.oil.gas systemd-journal[11482]: Runtime journal is using 8.0M (max allowed 300.0M, trying to leave 4.0G free of 251.6G available → current limit 300.0M).
Apr 22 18:04:35 sng-rplat-03.sgc.oil.gas systemd-journal[11482]: Journal started
Apr 22 18:04:35 sng-rplat-03.sgc.oil.gas systemd-journal[11482]: Permanent journal is using 3.9G (max allowed 4.0G, trying to leave 4.0G free of 28.4G available → current limit 4.0G).
Apr 22 18:04:36 sng-rplat-03.sgc.oil.gas systemd-journal[11482]: Time spent on flushing to /var is 21.078ms for 2523 entries.
Apr 22 18:05:18 sng-rplat-03.sgc.oil.gas systemd-journal[11482]: Suppressed 281 messages from /

● systemd-journal-flush.service - Flush Journal to Persistent Storage
   Loaded: loaded (/usr/lib/systemd/system/systemd-journal-flush.service; static; vendor preset: disabled)
   Active: active (exited) since Sat 2023-04-22 18:04:36 +05; 1 day 18h ago
     Docs: man:systemd-journald.service(8)
           man:journald.conf(5)
 Main PID: 11489 (code=exited, status=0/SUCCESS)
    Tasks: 0
   Memory: 0B
   CGroup: /system.slice/systemd-journal-flush.service

Apr 22 18:04:36 sng-rplat-03.sgc.oil.gas systemd[1]: Started Flush Journal to Persistent Storage.

