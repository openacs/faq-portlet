<?xml version="1.0"?>

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
