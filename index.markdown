---
layout: page
title: Philip Potter's blog
published: true
---
<ul class="unstyled">
{% for post in site.posts limit: 5 %}
    <li>
            <h1><a href="{{ post.url }}">{{ post.title }}</a></h1>
            <span>({{ post.date | date:"%Y-%m-%d" }})</span>
    </li>
    {{ post.content }}
  {% endfor %}
</ul>
