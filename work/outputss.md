---
layout: default
categories: 
    work
---
{% capture current_year %}{{ site.time | date: "%Y" }}{% endcapture %}

{% capture pager_html %}
<nav>
  <ul class="pager">
    <li ><a href="outputs.html"><span aria-hidden="true">&larr;</span> Newer</a></li>
    <li class="disabled"><a href="#"><span aria-hidden="true">&rarr;</span></a></li>
  </ul>
</nav>
{% endcapture %}
{{ pager_html }}

Leading Edge
------------
{% capture query_string %}{{ '@*[year<=' }}{{ current_year | minus:2 }}{{ '&& publisher !~ (I|i)n Press|(S|s)ubmitted && type !~ (U|u)pcoming|(A|a)ccepted]'}}{% endcapture %}
{% bibliography --offset 11 --file publications --file presentations --file misc --query {{ query_string }} %}

{{ pager_html }}
