{% from "shorewall/map.jinja" import map with context %}

shorewall:
  pkg:
    - installed
    - name: {{ map.pkg }}
  service.running:
    - enable: True
    - require:
      - pkg: shorewall

{{ map.macro_path }}/macro.SaltMaster:
  file.managed:
    - source: salt://shorewall/files/macro.SaltMaster
    - require:
      - pkg: shorewall
    - watch_in:
      - service: shorewall

{{ map.config_path }}/zones:
  file.managed:
    - source: salt://shorewall/files/zones.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: shorewall
    - watch_in:
      - service: shorewall

{{ map.config_path }}/interfaces:
  file.managed:
    - source: salt://shorewall/files/interfaces.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: shorewall
    - watch_in:
      - service: shorewall

{{ map.config_path }}/policy:
  file.managed:
    - source: salt://shorewall/files/policy.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: shorewall
    - watch_in:
      - service: shorewall

{{ map.config_path }}/rules:
  file.managed:
    - source: salt://shorewall/files/rules.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: shorewall
    - watch_in:
      - service: shorewall

