{
  flake.modules.nixos.boot = {
    # boot = {
    #   consoleLogLevel = 0;
    #   initrd.verbose = false;
    #   kernelParams = [
    #     "quiet"
    #     "splash"
    #     "rd.udev.log_level=3"
    #   ];
    #   loader = {
    #     efi.canTouchEfiVariables = true;
    #     systemd-boot.enable = true;
    #     timeout = 0;
    #   };
    #   plymouth.enable = true;
    # };

    boot.loader = {
      grub = {
        # enable = false;
        devices = [ "nodev" ];
        efiSupport = true;
        # enableCryptodisk =  true;
        # useOSProber = true; # yes there is a windows 11 nearby
      };
      timeout = 3; # default value 5
      #             grub.default = 3;            # 3 means 4rth entry starting with 0
      # grub.extraEntries = lib.strings.fileContents ./etc/grub-extra-entries.cfg;
      # grub.extraEntries = '' '';
      # see trikl-nixfig howto load extraEntries from a file
      efi = {
        canTouchEfiVariables = true;
        # efiSysMountPoint = "/efi";
      };
    };

  };
}
