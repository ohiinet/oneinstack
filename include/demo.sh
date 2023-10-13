#!/bin/bash

DEMO() {
  pushd ${oneinstack_dir}/src > /dev/null

  if [ -e "${php_install_dir}/bin/php" ]; then
    src_url=${mirror_link}/oneinstack/src/xprober.php && Download_src
    /bin/cp xprober.php ${wwwroot_dir}/default

    echo "<?php phpinfo() ?>" > ${wwwroot_dir}/default/phpinfo.php
    case "${phpcache_option}" in
      1)
        src_url=${mirror_link}/oneinstack/src/ocp.php && Download_src
        /bin/cp ocp.php ${wwwroot_dir}/default
        ;;
      2)
        sed -i 's@<a href="/ocp.php" target="_blank" class="links">Opcache</a>@<a href="/apc.php" target="_blank" class="links">APC</a>@' ${wwwroot_dir}/default/index.html
        ;;
      3)
        sed -i 's@<a href="/ocp.php" target="_blank" class="links">Opcache</a>@<a href="/xcache" target="_blank" class="links">xcache</a>@' ${wwwroot_dir}/default/index.html
        ;;
      4)
        /bin/cp eaccelerator-*/control.php ${wwwroot_dir}/default
        sed -i 's@<a href="/ocp.php" target="_blank" class="links">Opcache</a>@<a href="/control.php" target="_blank" class="links">eAccelerator</a>@' ${wwwroot_dir}/default/index.html
        ;;
      *)
        sed -i 's@<a href="/ocp.php" target="_blank" class="links">Opcache</a>@@' ${wwwroot_dir}/default/index.html
        ;;
    esac
  fi
  chown -R ${run_user}:${run_group} ${wwwroot_dir}/default
  [ -e /bin/systemctl ] && systemctl daemon-reload
  popd > /dev/null
}
