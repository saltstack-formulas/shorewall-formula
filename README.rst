=========
shorewall
=========

Install and configure shorewall (ipv4). As default, distribution shorewall package is installed
and configured according to the rules in pillar data.

The tags of pillar data are according to shorewall options.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``shorewall``
-------------

Installation and configuration of shorewall distribution package. 

``shorewall.upnp``
==================

Add upnp support. See http://shorewall.net/UPnP.html.

``Pillar``
==========

* Default is to install and configure shorewall for ipv4. If ipv6 is needed it must be configured in pillar.
* Each config item (zone, interface, rule, etc.) is configured for all configured ip versions (ipv4, ipv6) by default. If it is needed for one specific version this can be set in pillar with flag 'ipv': 'ipv: 4' or 'ipv: 6'.

See shorewall/pillar.example

``Notes``
=========

* NAT is not possible with IPv6, see http://shorewall.net/IPv6Support.html
* For traffic shaping either use simple (tcinterfaces and tcpri) or complex (tcdevices, tcclasses and tcrules)
