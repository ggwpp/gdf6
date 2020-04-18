module "vm-backend" {
    source = "../05module"

    region          = "ap-souteast1"
    zone            = "ap-souteast1-a"
    vm_name         = "backend-staging"
    vm_machine_type = "n1-standard-1"
}
