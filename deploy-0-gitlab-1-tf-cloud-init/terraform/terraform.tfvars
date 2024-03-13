##..Example variable
my_example_var = "This is an example Terraform variable"

##..Sets Cloud access IAM token generated with "Yandex Cloud CLI" (12 hours lifespan)
##  $ yc iam create-token
##  $ export TF_VAR_yc_token=$(yc iam create-token) && echo $TF_VAR_yc_token
#
yc_token = "<YOUR_YANDEX_CLOUD_IAM_TOKEN>"

##..Sets Yandex Cloud base IDs (cloud and folder id)
yc_cloud_id = "<YOUR_YANDEX_CLOUD_CLOUD_ID>"
yc_folder_id = "<YOUR_YANDEX_CLOUD_FOLDER_ID>"
