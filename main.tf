resource "cloudflare_record" "base" {
  name    = "benchung.dev"
  type    = "A"
  value   = local.machine_ipv4
  zone_id = var.zone_id
}

resource "cloudflare_record" "cname" {
  for_each = toset(local.cname_targets)

  name    = each.value
  type    = "CNAME"
  value   = cloudflare_record.base.name
  zone_id = var.zone_id
}
