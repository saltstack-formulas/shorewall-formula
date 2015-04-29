=========
shorewall
=========

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``shorewall``
-------------

Basically installation of shorewall. Will be extended using explicit pillar config.

``Pillar``
==========

* Default is to install and configure shorewall for ipv4. If ipv6 is needed it must be configured in pillar.
* Each config item (zone, interface, rule, etc.) is configured for all configured ip versions (ipv4, ipv6) by default. If it is needed for one specific version this can be set in pillar with flag 'ipv': 'ipv: 4' or 'ipv: 6'.

See shorewall/pillar.example
