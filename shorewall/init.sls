{% from "shorewall/map.jinja" import shorewall with context %}

shorewall:
  pkg:
    - installed
    - name: {{ shorewall.pkg }}
  service.running:
    - enable: True
    - require:
      - pkg: shorewall

