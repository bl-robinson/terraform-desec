
resource "desec_domain" "blrobinson-uk" {
  name = "blrobinson.uk"
}

# NS Records

resource "desec_rrset" "blrobinson-uk-NS" {
  domain  = desec_domain.blrobinson-uk.name
  subname = ""
  type    = "NS"
  records = [
    "ns1.desec.io.",
    "ns2.desec.org."
  ]
  ttl = 3600
}

# MX Records

resource "desec_rrset" "blrobinson-uk-MX" {
  domain  = desec_domain.blrobinson-uk.name
  subname = ""
  type    = "MX"
  records = [
    "5 mail.blrobinson.uk."
  ]
  ttl = 3600
}

# TXT Records

resource "desec_rrset" "blrobinson-uk-TXT" {
  domain  = desec_domain.blrobinson-uk.name
  subname = ""
  type    = "TXT"
  records = [
    "v=spf1 include:_spf.mailersend.net include:amazonses.com include:spf.mtasv.net ~all"
  ]
  ttl = 3600
}

resource "desec_rrset" "blrobinson-uk-dmarc-TXT" {
  domain  = desec_domain.blrobinson-uk.name
  subname = "_dmarc"
  type    = "TXT"
  records = [
    "v=DMARC1; p=none; rua=mailto:admin@blrobinson.uk"
  ]
  ttl = 3600
}

resource "desec_rrset" "blrobinson-uk-mlsned2-CNAME" {
  domain = desec_domain.blrobinson-uk.name
  subname = "mlsend2._domainkey"
  type = "CNAME"
  records = ["mlsend2._domainkey.mailersend.net."]
  ttl = 3600
}

resource "desec_rrset" "blrobinson-uk-mlsned2-mta" {
  domain = desec_domain.blrobinson-uk.name
  subname = "mta"
  type = "CNAME"
  records = ["mailersend.net."]
  ttl = 3600
}

# A

resource "desec_rrset" "blrobinson-uk-As" {
  for_each = {
    "www"            = ["88.202.151.191"],
    "adguard"        = ["88.202.151.191"],
    "foundry"        = ["88.202.151.191"],
    "grabs"          = ["88.202.151.191"],
    "home-assistant" = ["88.202.151.191"],
    "immich"         = ["88.202.151.191"],
    "mail"           = ["88.202.151.191"],
    "shed-cam"       = ["88.202.151.191"],
    "unifi"          = ["88.202.151.191"],
    "webmail"        = ["88.202.151.191"],
    "*.k8s.home"     = ["88.202.151.191"],
  }
  domain  = desec_domain.blrobinson-uk.name
  subname = each.key
  type    = "A"
  records = each.value
  ttl     = 3600
}

# AAAA
# All public AAAA records point to ::3 (nginx-ingress / public gateway).
# The k8s.home services are internally accessed via ::4 (gateway-ingress)
# using split-horizon DNS, but public DNS must route to ::3 so that
# Let's Encrypt HTTP-01 challenges can reach the cert-manager solver
# (which registers on both gateways). ::4 is firewalled from the internet.

resource "desec_rrset" "blrobinson-uk-AAAAs" {
  for_each = {
    ""                            = ["2a06:61c2:27ae:2::3"],
    "www"                         = ["2a06:61c2:27ae:2::3"],
    "unifi"                       = ["2a06:61c2:27ae:2::3"],
    "adguard"                     = ["2a06:61c2:27ae:2::3"],
    "grabs"                       = ["2a06:61c2:27ae:2::3"],
    "immich"                      = ["2a06:61c2:27ae:2::3"],
    "shed-cam"                    = ["2a06:61c2:27ae:2::3"],
    "foundry"                     = ["2a06:61c2:27ae:2::3"],
    "home-assistant"              = ["2a06:61c2:27ae:2::3"],
    "webmail"                     = ["2a06:61c2:27ae:2::3"],
    "container-registry.k8s.home" = ["2a06:61c2:27ae:2::3"],
    "prometheus.k8s.home"         = ["2a06:61c2:27ae:2::3"],
    "grafana.k8s.home"            = ["2a06:61c2:27ae:2::3"],
    "alertmanager.k8s.home"       = ["2a06:61c2:27ae:2::3"],
    "vaultwarden.k8s.home"        = ["2a06:61c2:27ae:2::3"],
  }
  domain  = desec_domain.blrobinson-uk.name
  subname = each.key
  type    = "AAAA"
  records = each.value
  ttl     = 3600
}
