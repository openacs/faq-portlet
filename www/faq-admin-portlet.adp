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


<if @faqs:rowcount@ gt 0>
<ul>
<multiple name="faqs">
  <li>
    <a href="@url@admin/one-faq?faq_id=@faqs.faq_id@" title="#faq-portlet.goto_faqs_faq_name_admin#">@faqs.faq_name@</a>
	<if @faqs.disabled_p@ eq "t">
		(#faq-portlet.Disabled# | <a href="faq/admin/faq-enable?faq_id=@faqs.faq_id@&referer=@referer@" title="#faq-portlet.enable_faqs_faq_name#">#faq-portlet.Enable#</a>)
	</if>
	<else>
		 (<a href="faq/admin/faq-disable?faq_id=@faqs.faq_id@&referer=@referer@" title="#faq-portlet.disable_faqs_faq_name#">#faq-portlet.Disable#</a>)
	</else>
  </li>
</multiple>
</ul>
</if>

<ul>
  <li><a href="@url@admin/faq-new" title="#faq-portlet.create_new_faq#">#faq-portlet.new_faq#</a></li>
</ul>
