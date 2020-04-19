#Creating 2 ec2 instances in 2 azs
resource "aws_instance" "ec2" {
  ami = var.amitype
  key_name = "custom-KP"
  vpc_security_group_ids = ["sg-0fdc9c8c32c542bfd"]
  subnet_id = "${element(var.subs,count.index)}"
  associate_public_ip_address = true
  instance_type = var.i_type
  user_data = "${file("ngx.sh")}"
  availability_zone = "${element(var.azs,count.index)}"
  count = length(var.azs)
  tags = {
    Name = "${var.project}-${count.index}"
  }
}

#Creating Application LB
resource "aws_lb" "alb" {
  name = var.albname
  load_balancer_type = var.lbtype
  internal = false
  security_groups = var.sgs
  subnets = var.subs
  tags = {
    name = var.albname
  }
}

#Creating Target Group for ALB
resource "aws_alb_target_group" "alb_tg_1" {
  name = var.alb_tg
  target_type = var.tgtype
  protocol = var.tgproto
  port = var.tgport
  vpc_id = var.vpc
}

#Attaching instaces to the TG
resource "aws_alb_target_group_attachment" "alb_tga" {
    depends_on = ["aws_instance.ec2"]
    target_group_arn = "${aws_alb_target_group.alb_tg_1.arn}"
    count = length(var.azs)
    target_id = element(aws_instance.ec2.*.id,count.index)
    port = var.tgport
}

#Adding Listner to the ALB
resource "aws_alb_listener" "alb_lnr" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port = var.tgport
  protocol = var.tgproto

  default_action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.alb_tg_1.arn}"
  }

}
