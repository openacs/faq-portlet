<if @shaded_p@ false>

  <if @no_faqs_p@ false>

    <if @one_instance_p@ eq 0>
      <ul>
    </if>
   
    @data@
  
    <if @one_instance_p@ eq 0>
      </ul>
    </if>

  </if>
  <else>
    <small>No FAQs</small>
  </else>

</if>
<else>
  &nbsp;
</else>
