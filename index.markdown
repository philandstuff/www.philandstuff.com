---
layout: page
title: Philip Potter's blog
published: true
---
<ul>
{% for post in site.posts limit: 5 %}
    <li>
            <a href="{{ post.url }}">{{ post.title }}</a>
            <span>({{ post.date | date:"%Y-%m-%d" }})</span>
    </li>
    {{ post.content }}
  {% endfor %}
</ul>
