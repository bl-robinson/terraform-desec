
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
    "baiu0nOyx5HArTMYuS3aIb5Ld4WlrG8l/oGtQWNkMdg=",
    "v=spf1 include:amazonses.com include:spf.mtasv.net ~all"
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

resource "desec_rrset" "blrobinson-uk-domainkey-TXT" {
  domain  = desec_domain.blrobinson-uk.name
  subname = "20231204151402pm._domainkey"
  type    = "TXT"
  records = [
    "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCCbe+M3NftspfCB75Jj7ZJfRJppUGwzDsee/F93BjYG32PZ33nHcgAc8kBWzCnE0fqke9f7o1miwbdrINQSWXahdgDH/WiO5/hUZlISZDFEmKAflRKvfVZLcjPG0GbXuNjEVlc/19PUeWFLLZd24yOj1kleAurS7+scfambnnnWwIDAQAB"
  ]
  ttl = 3600
}

# CNAME Records

resource "desec_rrset" "blrobinson-uk-ses-domainkey-CNAME" {
  for_each = toset(["itcsolhpd677rvyzuyjsniw2yvqmd4s5", "ku3bl5ok7jtmizeeh6joa4eyl4v7zbei", "ti2pehtynwwmmt6femfgt67byqrlusvv"])
  domain   = desec_domain.blrobinson-uk.name
  subname  = "${each.key}._domainkey"
  type     = "CNAME"
  records  = ["${each.key}.dkim.amazonses.com."]
  ttl      = 3600
}

resource "desec_rrset" "blrobinson-uk-sendgrid-domainkey-CNAME" {
  for_each = toset(["s1", "s2"])
  domain   = desec_domain.blrobinson-uk.name
  subname  = "${each.key}._domainkey"
  type     = "CNAME"
  records  = ["${each.key}.domainkey.u9065180.wl181.sendgrid.net."]
  ttl      = 3600
}

resource "desec_rrset" "blrobinson-uk-CNAMEs" {
  for_each = {
    "em6224"           = ["u9065180.wl181.sendgrid.net."],
    "freeagent-mailer" = ["pm.mtasv.net."],
    "*"                = ["benrobinson1993.ddns.net."],
    "*.k8s.home"       = ["benrobinson1993.ddns.net."]
  }
  domain  = desec_domain.blrobinson-uk.name
  subname = each.key
  type    = "CNAME"
  records = each.value
  ttl     = 3600
}

# A

resource "desec_rrset" "blrobinson-uk-As" {
  for_each = {
    "mail"           = ["88.202.151.191"],
  }
  domain  = desec_domain.blrobinson-uk.name
  subname = each.key
  type    = "A"
  records = each.value
  ttl     = 3600
  # Manually depend on in order to ensure that CNAMEs get deleted before As are Added.
  depends_on = [ desec_rrset.blrobinson-uk-CNAMEs ]
}
