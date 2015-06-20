{% from "shorewall/map.jinja" import map with context %}

shorewall_etcdefault:
  file.managed:
    - name: {{ map.etcdefault_file }}
    - source: salt://shorewall/files/etcdefault.jinja  
    - template: jinja  
    - watch_in:
      - service: shorewall_v4

{%- if 6 in salt['pillar.get']('shorewall:ipv', [4]) %}
shorewall6_etcdefault:
  file.managed:
    - name: {{ map.etcdefault6_file }}
    - source: salt://shorewall/files/etcdefault.jinja
    - template: jinja
    - watch_in:
      - service: shorewall_v6
{%- endif %}
