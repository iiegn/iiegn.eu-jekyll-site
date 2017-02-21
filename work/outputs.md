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

{% assign query_string = '@*[publisher ~= (I|i)n Press|(S|s)ubmitted|(A|a)ccepted || type ~= (U|u)pcoming|(S|s)ubmitted]' %}
{% capture res %}
{% bibliography --file publications --file presentations --file misc --query {{ query_string }} %}
{% endcapture %}
{% if res.size > 50 %}
Upcoming (or still Waiting) 
-----------------------------
{{ res }}
{% endif %}


{% capture query_string %}{{ '@*[year>=' }}{{ current_year | minus:1 }}{{ '&& publisher !~ (I|i)n Press|(S|s)ubmitted|(A|a)ccepted && type !~ (U|u)pcoming|(S|s)ubmitted]' }}{% endcapture %}
{% capture res %}
{% bibliography --file publications --file presentations --file misc --query {{ query_string }} %}
{% endcapture %}
{% if res.size > 50 %}
Bleeding Edge
-------------
{{ res }}
{% endif %}


{% capture query_string %}{{ '@*[year<=' }}{{ current_year | minus:2 }}{{ '&& publisher !~ (I|i)n Press|(S|s)ubmitted|(A|a)ccepted && type !~ (U|u)pcoming|(S|s)ubmitted]' }}{% endcapture %}
{% capture res %}
{% bibliography --max 10 --file publications --file presentations --file misc --query {{ query_string }} %}
{% endcapture %}
{% if res.size > 50 %}
Cutting Edge
------------
{{ res }}
{% endif %}

{{ pager_html }}
