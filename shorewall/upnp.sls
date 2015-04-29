{% from "shorewall/map.jinja" import map with context %}

include:
  - shorewall

shorewall_upnp_pkg:
  pkg.installed:
    - name: {{ map.upnp_pkg }}
