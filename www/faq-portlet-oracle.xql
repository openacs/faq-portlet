<?xml version="1.0"?>
<!--

  Copyright (C) 2001, 2002 OpenForce, Inc.

  This file is part of dotLRN.

  dotLRN is free software; you can redistribute it and/or modify it under the
  terms of the GNU General Public License as published by the Free Software
  Foundation; either version 2 of the License, or (at your option) any later
  version.

  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

-->


<queryset>
<rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="faqs_select">
    <querytext>
      select f.faq_id, f.faq_name
      from acs_objects o, faqs f
      where object_id = f.faq_id
      and context_id = :package_id
    </querytext>
</fullquery>

<fullquery name="faqs_check">
    <querytext>
    select 1
    from dual where exists (select 1 from acs_objects o, faqs f
    where object_id = f.faq_id
    and context_id = :package_id)
    </querytext>
</fullquery>

</queryset>
