include:
  - shorewall

/etc/shorewall/zones:
  file.managed:
    - source: salt://shorewall/files/one-interface/zones
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: shorewall
    - watch_in:
      - service: shorewall
    
/etc/shorewall/interfaces:
  file.managed:
    - source: salt://shorewall/files/one-interface/interfaces
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: shorewall
    - watch_in:
      - service: shorewall
    
/etc/shorewall/policy:
  file.managed:
    - source: salt://shorewall/files/one-interface/policy
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: shorewall
    - watch_in:
      - service: shorewall
    
/etc/shorewall/rules:
  file.managed:
    - source: salt://shorewall/files/one-interface/rules
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: shorewall
    - watch_in:
      - service: shorewall
    
