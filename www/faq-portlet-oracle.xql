<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="select_faqs">
        <querytext>
            select acs_objects.context_id as package_id,
                   (select apm_packages.instance_name
                    from apm_packages
                    where apm_packages.package_id = apm_package.parent_id(acs_objects.context_id)) as community_name,
                   (select site_node.url(site_nodes.node_id)
                    from site_nodes
                    where site_nodes.object_id = acs_objects.context_id) as url,
                   faqs.faq_id,
                   faqs.faq_name
            from faqs,
                 acs_objects
            where faqs.faq_id = acs_objects.object_id
            and acs_objects.context_id in ([join $list_of_package_ids ", "])
        </querytext>
    </fullquery>

</queryset>
