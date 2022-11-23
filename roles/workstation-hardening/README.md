# Tasks

## apparmor.yml

- Ensures that apparmor is installed and enabled
- Enable apparmor profile for firefox that is disabled by default ([https://help.ubuntu.com/community/AppArmor](https://help.ubuntu.com/community/AppArmor))

## auditd.yml

- Ensure that auditd user components are installed
- Ensure that auditd service is enabled

## crontab.yml

- Ensure that root can only use crontab

## disable_core_dumps.yml

- Disables core dumps

## etc_issue.yml

- Content from `etc_issue_and_issue_net_content` variable is set to `/etc/issue` and `/etc/issue.net`.

## grub_cmd_ipv6_apparmor.yml

- Disables IPv6 and ensures that apparmor is enabled with GRUB configuration.

## harden_compilers.yml

- Ensures that root can only use compilers if checked paths exist. You can set list of compilers with variable `compiler_paths` (absolute paths).

## home_dir_permissions.yml

- Set all home directories to 0750

## kernel_modules.yml

- Disable not needed filesystems (recommended e.g. in CIS benchmarks)

## kernel.yml

- Hardens kernel parameters set in `hardened_kernel_params` variable.
- Additionally creates a service that starts after boot and sets `/proc/sys/kernel/modules_disabled`. Idea is that kernel modules can load during the boot and is prevented after that.

## login_defs.yml

- Sets some recommended values to `/etc/login.defs`
  - Values are currently hard-coded. Modify `login_defs.yml` directly to change.

## proc_hidepid.yml

- Allow users only see their own processes with command `ps`.

## rkhunter.yml

- Install rkhunter. Remove task from `workstation-hardening/vars/main.yml` if you don't want to install it.

## systemd.yml

- Stop and disable services that are defined in `systemd_services_to_stop_and_disable` variable. The task checks if a service exists before it attempts to disable/stop it.

## ufw.yml

- Sets common workstation firewall rules:

```
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
80/tcp                     ALLOW OUT   Anywhere                  
443/tcp                    ALLOW OUT   Anywhere                  
53/tcp                     ALLOW OUT   Anywhere                  
22/tcp                     ALLOW OUT   Anywhere                  
123/udp                    ALLOW OUT   Anywhere                  
53/udp                     ALLOW OUT   Anywhere                  
67/udp                     ALLOW OUT   Anywhere                  
68/udp                     ALLOW OUT   Anywhere      
```

- Defaults to allow outgoing even though it sets some outbound rules. To change this:
  - Set `ufw_default_out` variable to `'deny'`
  - Ensure you have needed rules in `ufw_tcp_allow_out` and `ufw_udp_allow_out` variables.

## usbguard.yml

- Ensures USBguard is installed and creates rules that allows currently attaches devices.
  - Create new rules with currently attached devices with command `sudo usbguard generate-policy > /etc/usbguard/rules.conf`.

## falco.yml

- Install and configure falco

# HIDS

The role has variables `falco_enable` and `auditd_enable` that expect boolean value. Based on the value it's determined if falco and/or auditd is installed and configured.
It's also possible to modify workstation/roles/workstation-hardening/vars/main.yml and remove falco or auditd task from `hardening_tasks_include` list.

Both have some default rules that are included when installed, but it's easy to add own rules under the role:

* Falco: Add rule files with `yaml.j2` extension under the path `workstation/roles/workstation-hardening/templates/falco_rules/`
* Auditd: Add rule files with `.rules` extension under the path `workstation-hardening/templates/auditd/`

Both use the template module so it's possible to use Jinja2 expressions inside rule files.
