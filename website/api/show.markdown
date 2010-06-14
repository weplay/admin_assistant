---
layout: api
title:  Show
---

Show configuration affects what is displayed in a show page, e.g. `/admin/blog_posts/show/5`.

### Show config options

#### columns

    admin_assistant_for BlogPost do |aa|
      aa.show.columns :user, :title, :body
    end

Shows only these columns in the show page.

### Partials

#### \_\[column\]\_for_show.html.erb

If this partial is present, it will be rendered instead of the default HTML for the column.
