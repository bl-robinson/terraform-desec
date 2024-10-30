import {
  id = "blrobinson.uk"
  to = desec_domain.blrobinson-uk
}

import {
  id = "blrobinson.uk/@/NS"
  to = desec_rrset.blrobinson-uk-NS
}

import {
  id = "blrobinson.uk/@/MX"
  to = desec_rrset.blrobinson-uk-MX
}

import {
  id = "blrobinson.uk/@/TXT"
  to = desec_rrset.blrobinson-uk-TXT
}

import {
  id = "blrobinson.uk/_dmarc/TXT"
  to = desec_rrset.blrobinson-uk-dmarc-TXT
}

import {
  for_each = toset(["itcsolhpd677rvyzuyjsniw2yvqmd4s5", "ku3bl5ok7jtmizeeh6joa4eyl4v7zbei", "ti2pehtynwwmmt6femfgt67byqrlusvv"])
  id       = "blrobinson.uk/${each.key}._domainkey/CNAME"
  to       = desec_rrset.blrobinson-uk-ses-domainkey-CNAME[each.key]
}

import {
  for_each = toset(["s1", "s2"])
  id       = "blrobinson.uk/${each.key}._domainkey/CNAME"
  to       = desec_rrset.blrobinson-uk-sendgrid-domainkey-CNAME[each.key]
}

import {
  id = "blrobinson.uk/20231204151402pm._domainkey/TXT"
  to = desec_rrset.blrobinson-uk-domainkey-TXT
}

import {
  for_each = toset([
    "em6224",
    "freeagent-mailer",
  ])
  id = "blrobinson.uk/${each.key}/CNAME"
  to = desec_rrset.blrobinson-uk-CNAMEs[each.key]
}
