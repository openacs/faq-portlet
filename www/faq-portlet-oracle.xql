<?xml version="1.0"?>

<queryset>
<rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="faqs_select">
    <querytext>
      select f.faq_id, f.faq_name, entry_id, question
      from acs_objects o, faqs f, faq_q_and_as qa
      where object_id = f.faq_id
      and context_id = :package_id
      and qa.faq_id(+) = f.faq_id
    </querytext>
</fullquery>

</queryset>
