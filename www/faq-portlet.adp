<%

    #
    #  Copyright (C) 2001, 2002 OpenForce, Inc.
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

<if @shaded_p@ ne "t">

  <if @faqs:rowcount@ gt 0>

<%
    set new_package_id ""
    set old_package_id ""
%>

    <if @one_instance_p@ false>
      <table border="0" bgcolor="white" cellpadding="2" cellspacing="3" width="100%">
        <tr>
          <td><strong>Name</strong></td>
          <td><strong>Group</strong></td>
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
        <tr bgcolor="#ececec">
      </if>
      <else>
        <tr bgcolor="#ffffff">
      </else>
        <td><a href="@faqs.url@one-faq?faq_id=@faqs.faq_id@">@faqs.faq_name@</a></td>
        <td>@faqs.parent_name@</td>
      </tr>
    </else>

<%
    set old_package_id $new_package_id
%>

    <if @one_instance_p@ false and @new_package_id@ ne @old_package_id@>
      </tr>
    </if>
</multiple>

    <if @one_instance_p@ false>
      </table>
    </if>

  </if>
  <else>
    <small>No FAQs</small>
  </else>

</if>
<else>
&nbsp;
</else>
