# sf-dvicx-diploma-0-dev / deploy-0-gitlab-1-tf-cloud-init
For Skill Factory study project (Diploma, tests mono repo)
Configuring Gitlab with Terraform and Cloud-Init

<br>

### Quick Info : : Быстрая информация

```bash
#--Общее описание

Опорный проект по установке и настройке self-hosted GitLab в Облаке Yandex Cloud на ВМ Ubuntu 22.04 LTS
с помощью IaC конфигурации Hashicorp Terraform и функционала Cloud-Init доступного в ОС.
Ansible в данном решении не применяется


#--Требования
1. Установить и настроить инструмент "Yandex Cloud CLI" (yc) для работы с Яндекс Облаком
   в результате должна выполнятся команда генерирующая временный токент авторизации (IAM-токен)
   со сроком жизни не более 12 часов
   *существуют другие способы авторизации в облаке, но в данном проекте выбран именно этот

        $ yc iam create-token


2. Создать файл переменных Terraform 
   *который будет содержать секретные данные необходимые для авторизации в Облаке

    - создаем файл
      $ cd terraform
      $ touch protected/protected.tfvars

    - указываем в переменных значение своего токена, а также ID Облака и ID Каталога
      $ nano protected/protected.tfvars

            yc_token = "t1.9eu..XvcfUCA"
            yc_cloud_id = "b1g..0qi2"
            yc_folder_id = "b1g..qkuj"


3. Создать локальную Cloud-Init конфигурацию 
   *которая будет содержать секретные данные необходимые для создания пользователя на ВМ
    а также инструкции по установке ПО на созданную ВМ

     $ touch protected/cloud-init_instance-data.json

   - заменить переменные в конфигурации на свои значения по показанному ниже примеру
     
     $ nano protected/cloud-init_instance-data.json

            {
              "customdata": {
                "user_mail": "operator@email.su",
                "user_name": "operator",
                "user_password": "$6$rounds=4096$g...F9TTbr.",
                "user_pubkey": "ssh-ed25519 AAAA...HqZicm operator@email.su"
              }
            }

      где 
          "user_mail"     - (не обязательно) - email для создаваемого на ВМ пользователя 
          "user_name"     - (обязательно)    - имя пользователя
          "user_password" - (обязательно)    - хэш пароля пользователя созданный с помощью утилиты "mkpasswd" из пакета "whois"
          "user_pubkey"   - (обязательно)    - публичный ssh-ключ пользователя для возможности авторизации по ssh-ключу при ssh-подключении к ВМ

  - проверить что одно из значений считывается с помощью утилиты "cloud-init"

      $ cloud-init query --instance-data protected/cloud-init_instance-data.json customdata.user_name
      
            operator


#--Команды
   *создание и уничтожение ВМ в облаке производится с помощью шелл-скриптов
    либо вручную с помощью отдельных команд которые описаны в скриптах

$ cd terraform

$ terraform init
    ..
        в результате, в каталог .terraform будут скачаны и установлены все необходимые
        компоненты Terraform необходимые для выполнения конфигурации "main.tf"

$ ./project_deploy.sh
    ..
        Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

        Outputs:

        host0_info = "gitlab: gitlab: 10.0.10.11: 158.160.73.120"
        host0_ip_external = "158.160.73.120"


$ ./project_ssh2host0.sh

        devops@gitlab:~$ curl -s 2ip.ru; hostname -I; whoami; pwd

                158.160.73.120
                10.0.10.11 
                devops
                /home/devops

        devops@gitlab:~$ sudo su
        root@gitlab:~# shutdown -h now

                Connection to 158.160.73.120 closed by remote host.
                Connection to 158.160.73.120 closed.


$ ./project_undeploy.sh

        Destroy complete! Resources: 1 destroyed.

```
<br><br>


### Changelog : : История изменений

```bash
v20240313_1447 :: deploy-0-gitlab-1-tf-cloud-init
  - реализован каркас Terraform конфигурации создающий x1 ВМ в облаке Yandex Cloud
    и настраивающий ее с помощью Cloud-Init функционала ОС Ubuntu 22.04

```
<br>
