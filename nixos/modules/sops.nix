{
  config,
  pkgs,
  ...
}: {
  sops = {
    defaultSopsFile = ../../secrets/email.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];

    secrets = {
      "email/address" = {owner = "travis";};
      "email/password" = {owner = "travis";};
      "email/smtp_server" = {owner = "travis";};
      "email/imap_server" = {owner = "travis";};
    };
  };
}
