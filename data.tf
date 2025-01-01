
data "http" "ipv4" {
  url = "https://ipv4.icanhazip.com"
}

locals {
  file_contents = [
    for line in split("\n", var.caddyfile_contents) :
    split(" ", line)[0] if can(regex("([[:alnum:]]\\.?) {", line))
  ]
  cname_targets = [for record in local.file_contents : split(".", record)[0] if length(split(".", record)) == 3]
  machine_ipv4  = chomp(data.http.ipv4.response_body)
}
