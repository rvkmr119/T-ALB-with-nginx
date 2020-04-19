variable "albname" {
  }
variable "region" {
  }
variable "lbtype" {
  }
variable "sgs" {
  }
variable "subs" {
  }
variable "alb_tg" {
  }
variable "tgtype" {
  }
variable "tgproto" {
  }
variable "tgport" {
  default = "80"
  }
variable "vpc" {
  }
variable "azs" {
  type = "list"
  default = ["us-east-1a", "us-east-1b"]
  }
variable "i_type" {
  }
variable "project" {
  }
variable "amitype" {
  }
