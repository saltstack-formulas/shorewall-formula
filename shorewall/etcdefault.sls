{% from "shorewall/map.jinja" import map with context %}

shorewall_etcdefault:
  file.managed:
    - name: {{ map.etcdefault_file }}
    - source: salt://shorewall/files/etcdefault.jinja  
    - template: jinja  
    - watch_in:
      - service: shorewall_v4

