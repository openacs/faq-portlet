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

<if @shaded_p@ false>

  <if @faqs:rowcount@ gt 1>

<%
    set new_package_id ""
    set old_package_id ""
%>

    <if @one_instance_p@ false>
      <table border="0" bgcolor="white" cellpadding="2" cellspacing="0" width="100%">
        <tr class="table-header">
          <td><strong class="table-header">#faq-portlet.name#</strong></td>
          <td><strong class="table-header">#faq-portlet.group#</strong></td>
        </tr>
    </if>

<multiple name="faqs">

<% set new_package_id $faqs(package_id) %>

    <if @one_instance_p@ false and @new_package_id@ ne @old_package_id@>
      <tr>
    </if>

    <if @one_instance_p@>
      <li>
        <a href="@faqs.url@one-faq?faq_id=@faqs.faq_id@">@faqs.faq_name@</a>
      </li>
    </if>
    <else>
      <if @faqs.rownum@ odd>
        <tr class="odd">
      </if>
      <else>
        <tr class="even">
      </else>
        <td><a href="@faqs.url@one-faq?faq_id=@faqs.faq_id@">@faqs.faq_name@</a></td>
        <td>@faqs.parent_name@</td>
      </tr>
    </else>

<% set old_package_id $new_package_id %>

</else>
    <if @one_instance_p@ false and @new_package_id@ ne @old_package_id@>
      </tr>
    </if>
</multiple>

    <if @one_instance_p@ false>
      </table>
    </if>

  </if>
  <else>
    <if @faqs:rowcount@ eq 1>
      <a href="@faq_url@one-faq?faq_id=@faq_id@">@faq_name@</a>
      <ul>
<multiple name="questions">
        <li><a href="@faq_url@one-question?entry_id=@questions.entry_id@">@questions.question@</a></li>
</multiple>
      </ul>
    </if>
    <else>
      <small>#faq-portlet.no_faqs#</small>
    </else>
  </else>

</if>
<else>
  &nbsp;
</else>






