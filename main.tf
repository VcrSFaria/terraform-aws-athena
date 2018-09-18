provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "${var.region}"
}

resource "aws_s3_bucket" "gerdau_s3_datalake" {
  bucket = "${var.datalake_name}"

  acl = "${var.acl}"
  force_destroy = "${var.force}"

  tags {
      Name = "${var.name}"
  }
}

resource "aws_athena_database" "athena_datalake" {
   name = "${var.athena_name}"
   bucket = "${aws_s3_bucket.gerdau_s3_datalake.bucket}" 
}

resource "aws_athena_named_query" "athena_datalake_query" {
   name = "${var.name_query}"
   database = "${aws_athena_database.athena_datalake.name}"
   query = "SELECT * FROM ${aws_athena_database.athena_datalake.name} limit 10;"
}


