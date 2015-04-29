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

