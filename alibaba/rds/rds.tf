variable "access_key"{}
variable "secret_key"{}
variable "region"{}
variable "zone"{}
variable "database_user_name"{}
variable "database_name"{}
variable "database_character"{}
variable "database_user_password"{}

provider "alicloud" {
    access_key          =   "${var.access_key}"
    secret_key          =   "${var.secret_key}"
    region              =   "${var.region}"
}

resource "alicloud_vpc" "default"{
    name                =   "vpc-rds"
    cidr_block          =   "172.16.0.0/16"
}

resource "alicloud_vswitch" "default"{
    name                =   "vswitch-rds"
    vpc_id              =   "${alicloud_vpc.default.id}"
    cidr_block          =   "172.16.0.0/24"
    availability_zone   =   "${var.zone}"
}

resource "alicloud_db_instance" "default"{
    engine              =   "MySQL"
    engine_version      =   "5.7"
    instance_type       =   "rds.mysql.t1.small"
    instance_storage    =   "5"
    vswitch_id          =   "${alicloud_vswitch.default.id}"
}

resource "alicloud_db_database" "default"{
    name                =   "${var.database_name}"
    character_set       =   "${var.database_character}"
    instance_id         =   "${alicloud_db_instance.default.id}"
}

resource "alicloud_db_account" "default"{
    name                =   "${var.database_user_name}"
    password            =   "${var.database_user_password}"
    instance_id         =   "${alicloud_db_instance.default.id}"

}