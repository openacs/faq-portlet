<?xml version="1.0"?>

<queryset>

  <fullquery name="faq_q_and_as_count_select">
    <querytext>
      select count(*) as count 
      from acs_objects o, faqs f
      where object_id = faq_id
      and context_id = :package_id
    </querytext> 
  </fullquery>

</queryset>
