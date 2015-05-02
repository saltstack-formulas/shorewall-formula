{% from "shorewall/map.jinja" import map with context %}

{%- set ipv = salt['pillar.get']('shorewall:ipv', [4]) %}
{%- do ipv.append(4) if not 4 in ipv %}

{# Iterate over all given ip versions in pillar #}
{%- for v in ipv %}

{%- set pkg = map['pkg_v{0}'.format(v)] %}
{%- set name = 'shorewall_v{0}'.format(v) %}
{%- set config_path = map['config_path_v{0}'.format(v)] %}
{%- set service = map['service_v{0}'.format(v)] %}

{# Install required packages #}
shorewall_v{{ v }}:
  pkg:
    - installed
    - name: {{ pkg }}
  service.running:
    - name: {{ service }}
    - enable: True

{# Create config files #}
{%-    for config in map.config_files %}
{# NAT is not possible for IPv6, see http://shorewall.net/IPv6Support.html #}
{%-      if config == 'masq' and v == 6 %}{% continue %}{% endif %}
{# Interfaces for traffic shaping should be declared only once, see http://shorewall.net/simple_traffic_shaping.html #}
{%-      if config == 'tcinterfaces' and v == 6 %}{% continue %}{% endif %}
{%-      if config == 'tcdevices' and v == 6 %}{% continue %}{% endif %}
{%-      if config == 'tcclasses' and v == 6 %}{% continue %}{% endif %}

shorewall_v{{ v }}_config_{{ config }}:
  file.managed:
    - name: "{{ config_path }}/{{ config }}"
    - source: salt://shorewall/files/{{ config }}.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: {{ name }}
    - watch_in:
      - service: {{ name }}
    - context:
      ipv: {{ v }}

{%-   endfor %}
{%- endfor %}

{# Install macro files #}
shorewall_config_macro:
  file.managed:
    - name: "{{ map.macro_path }}/macro.SaltMaster"
    - source: salt://shorewall/files/macro.SaltMaster
    - require:
      - pkg: shorewall_v6
    - watch_in:
      - service: shorewall_v6

{#- check if we should enable simple traffic shaping #}
{%- if salt['pillar.get']('shorewall:tcinterfaces', False) %}

shorewall_enable_tc_simple_v4:
  file.replace:
    - name: {{ map.config_path_v4 }}/shorewall.conf
    - pattern: "TC_ENABLED=.*"
    - repl: "TC_ENABLED=Simple"
    - watch_in:
      - service: shorewall_v4

shorewall_enable_tc_simple_v6:
  file.replace:
    - name: {{ map.config_path_v6 }}/shorewall6.conf
    - pattern: "TC_ENABLED=.*"
    - repl: "TC_ENABLED=Simple"
    - watch_in:
      - service: shorewall_v6

{%- endif %}

{#- check if we should enable complex traffic shaping #}
{%- if salt['pillar.get']('shorewall:tcdevices', False) %}

shorewall_enable_tc_simple_v4:
  file.replace:
    - name: {{ map.config_path_v4 }}/shorewall.conf
    - pattern: "TC_ENABLED=.*"
    - repl: "TC_ENABLED=Internal"
    - watch_in:
      - service: shorewall_v4

shorewall_enable_tc_simple_v6:
  file.replace:
    - name: {{ map.config_path_v6 }}/shorewall6.conf
    - pattern: "TC_ENABLED=.*"
    - repl: "TC_ENABLED=Internal"
    - watch_in:
      - service: shorewall_v6

{%- endif %}
