define ufw::rules() {

  ufw::allow { "snaplogic-gw":
    from => "12.90.36.218",
  }

  ufw::allow { "jenkins.int.snaplogic.com":
    from => "50.56.216.101",
  }

  ufw::allow { "SnapLogicVPN":
    from => "10.8.8.0/24",
  }

  ufw::allow { "buildmaster.eng.snaplogic.com":
    from => "174.129.212.180",
  }

  ufw::allow { "linjenkins1":
    from => "209.114.36.218",
  }

  ufw::allow { "linjenkins2":
    from => "174.143.143.183",
  }

  ufw::allow { "linjenkins3":
    from => "173.203.237.224",
  }

  ufw::allow { "linjenkins4":
    from => "174.143.142.218",
  }

  ufw::allow { "linjenkins5":
    from => "174.143.143.168",
  }

  ufw::allow { "linjenkins6":
    from => "50.56.233.39",
  }

  ufw::allow { "adm1-external":
    from => "184.106.229.119",
  }

  ufw::allow { "adm2-external":
    from => "184.106.229.120",
  }

  ufw::allow { "adm1-internal":
    from => "10.179.122.33",
  }

  ufw::allow { "adm2-internal":
    from => "10.179.122.34",
  }

  ufw::allow { "ltcontrollers.snaplogic.com":
    from => "50.57.105.22",
  }

  ufw::allow { "Ricardos-home":
    from => "99.6.132.0/22",
  }

  ufw::allow { "Martins-home":
    from => "24.7.21.9",
  }

  ufw::allow { "puppet.eng.snaplogic.com":
    from => "50.57.74.121",
  }

  ufw::allow { "nagios.eng.snaplogic.com":
    from => "50.57.45.152",
  }

  ufw::allow { "Lohikas-gateway":
    from => "91.213.92.3",
  }

  ufw::allow { "qaauto1.eng.snaplogic.com":
    from => "50.57.154.17",
  }

  ufw::allow { "qaauto2.eng.snaplogic.com":
    from => "50.57.153.77",
  }

  ufw::allow { "qaauto3.eng.snaplogic.com":
    from => "50.57.229.120",
  }

  ufw::allow { "qaauto4.eng.snaplogic.com":
    from => "50.57.229.165",
  }

  ufw::allow { "qaauto5.eng.snaplogic.com":
    from => "50.57.220.27",
  }

  ufw::allow { "qaauto6.eng.snaplogic.com":
    from => "50.57.226.252",
  }

  ufw::allow { "qaauto7.eng.snaplogic.com":
    from => "50.57.220.251",
  }

  ufw::allow { "qaauto8.eng.snaplogic.com":
    from => "50.57.220.20",
  }

  ufw::allow { "livedev.eng.snaplogic.com":
    from => "209.114.38.148",
  }

  ufw::allow { "forge1.snaplogic.com":
    from => "174.143.142.103",
  }

  ufw::allow { "forge2.snaplogic.com":
    from => "173.203.237.144",
  }

  ufw::allow { "Shashis-home":
    from => "76.126.244.86",
  }

  ufw::allow { "Dhirajs-home":
    from => "108.85.45.125",
  }

  ufw::allow { "Tims-home":
    from => "24.7.60.83",
  }

  ufw::allow { "Jims-home":
    from => "69.42.5.8",
  }

  ufw::allow { "Dianes-home":
    from => "24.5.183.161",
  }

  ufw::allow { "Dreas-home":
    from => "24.7.17.3",
  }

  ufw::allow { "testy.eng.snaplogic.com":
    from => "108.166.109.208",
  }


}
