locals {
  admin_users = {
    "junwoo" = {
      name        = "junwoo"
      path        = "/"
      description = "junwoo's admin account."
      tags = {
        Name = "junwoo"
      },
    }

    "dongin" = {
      name        = "dongin"
      path        = "/"
      description = "dongin's admin account."
      tags = {
        Name = "dongin"
      }
    },

    "juntae" = {
      name        = "juntae"
      path        = "/"
      description = "juntae's admin account."
      tags = {
        Name = "juntae"
      }
    }
  }
}

module "admin_user" {
  for_each = local.admin_users

  source      = "./modules/admin_user"
  name        = each.value.name
  path        = each.value.path
  description = each.value.description
  tags        = each.value.tags
}
