
<if @faqs:rowcount@ eq 0>
<i>No FAQs</i>
</if>
<else>
<ul>
<multiple name="faqs">
<li><a href=@url@one-faq?faq_id=@faqs.faq_id@>@faqs.faq_name@</a> &nbsp; - &nbsp; <a href=@url@admin/one-faq?faq_id=@faqs.faq_id@>Administration</a>
</multiple>
</ul>
</else>
<p>
<a href=@url@admin/faq-new>New FAQ</a>


