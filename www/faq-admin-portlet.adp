<%

    #
    #  Copyright (C) 2001, 2002 MIT
    #
    #  This file is part of dotLRN.
    #
    #  dotLRN is free software; you can redistribute it and/or modify it under the
    #  terms of the GNU General Public License as published by the Free Software
    #  Foundation; either version 2 of the License, or (at your option) any later
    #  version.
    #
    #  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
    #  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    #  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
    #  details.
    #

%>


<ul>
<multiple name="faqs">
  <li>
    <a href="@url@admin/one-faq?faq_id=@faqs.faq_id@">@faqs.faq_name@</a>
	<if @faqs.disabled_p@ eq "t">
		(Disabled | <a href=faq/admin/faq-enable?faq_id=@faqs.faq_id@&referer=@referer@>Enable</a>)
	</if>
	<else>
		 (<a href=faq/admin/faq-disable?faq_id=@faqs.faq_id@&referer=@referer@>Disable</a>)
	</else>
  </li>
</multiple>
  <br>
  <li><a href="@url@admin/faq-new">New FAQ</a></li>
</ul>
