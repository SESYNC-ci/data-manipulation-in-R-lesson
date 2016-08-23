---
reveal: "https://cdn.rawgit.com/hakimel/reveal.js/3.3.0"
layout: slideshow
---

{% for p in site.pages %}
{% if p.url == '/' %}{{ p.content}}{% endif %}
{% endfor %}
