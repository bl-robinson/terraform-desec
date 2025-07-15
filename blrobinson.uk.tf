
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
    "mail"       = ["88.202.151.191"],
    "*"          = ["88.202.151.191"],
    "*.k8s.home" = ["88.202.151.191"]

  }
  domain  = desec_domain.blrobinson-uk.name
  subname = each.key
  type    = "A"
  records = each.value
  ttl     = 3600
}
