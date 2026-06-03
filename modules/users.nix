{
  flake.modules.nixos.users =
    { config, pkgs, ... }:
    {

      # create groups with <name> and <guid>
      users.groups."gtom".gid = 1020;
      users.groups."gtest".gid = 1030;

      users.users.${config.primaryUser} = {
        # description = ${config.primayUser}.fullname;
        # shell = pkgs.zsh;
        # shell = pkgs.fish;
        isNormalUser = true;
        uid = 1010;
        group = "gtom";
        #  password = "firstlogin";  # TODO change after first rebuild
        extraGroups = [ "wheel"
                        "networkmanager"
                        "video" ];
      };

      # users.users.${config.primaryUser} = {
      #   description = config.profile.fullName;
      #   extraGroups = [
      #     "networkmanager"
      #     "video"
      #     "wheel"
      #   ];
      #   isNormalUser = true;
      # };

      system.activationScripts.setUserAvatar.text = ''
        mkdir -p /var/lib/AccountsService/{icons,users}
        cp ${config.profile.avatar} "/var/lib/AccountsService/icons/${config.primaryUser}"

        touch "/var/lib/AccountsService/users/${config.primaryUser}"

        if ! grep -q "^Icon=" "/var/lib/AccountsService/users/${config.primaryUser}"; then
          if ! grep -q "^\[User\]" "/var/lib/AccountsService/users/${config.primaryUser}"; then
            echo "[User]" >> "/var/lib/AccountsService/users/${config.primaryUser}"
          fi
          echo "Icon=/var/lib/AccountsService/icons/${config.primaryUser}" >> "/var/lib/AccountsService/users/${config.primaryUser}"
        fi
      '';

      security.sudo.wheelNeedsPassword = false;
    };

  flake.modules.darwin.users =
    { config, ... }:
    {
      users.users.${config.primaryUser} = {
        name = config.primaryUser;
        home = "/Users/${config.primaryUser}";
      };

      system.primaryUser = config.primaryUser;
    };
}
