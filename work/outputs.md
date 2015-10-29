---
layout: default
title: outputs
categories: 
    work
---
{% capture current_year %}{{ site.time | date: "%Y" }}{% endcapture %}

{% capture pager_html %}
<nav>
  <ul class="pager">
    <li class="disabled"><a href="#"><span aria-hidden="true">&larr;</span></a></li>
    <li><a href="outputss.html">Older <span aria-hidden="true">&rarr;</span></a></li>
  </ul>
</nav>
{% endcapture %}
{{ pager_html }}

Upcoming (or still Waiting)
-----------------------------
{% assign query_string = '@*[mendeley-tags ~= upcoming|in Press|submitted]' %}
{% bibliography --file publications --file presentations --file misc --query {{ query_string }} %}

Bleeding Edge
-------------
{% capture query_string %}{{ '@*[year>=' }}{{ current_year | minus:1 }}{{ '&& mendeley-tags != upcoming && mendeley-tags != in Press && mendeley-tags != submitted]' }}{% endcapture %}
{% bibliography --file publications --file presentations --file misc --query {{ query_string }} %}

Cutting Edge
------------
{% capture query_string %}{{ '@*[year<=' }}{{ current_year | minus:2 }}{{ '&& mendeley-tags != upcoming && mendeley-tags != in Press && mendeley-tags != submitted]' }}{% endcapture %}
{% bibliography --max 10 --file publications --file presentations --file misc --query {{ query_string }} %}

{{ pager_html }}
