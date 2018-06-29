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

# faq-portlet/www/faq-portlet.tcl

ad_page_contract {
    The logic for the faq portlet.

    @creation-user Arjun Sanyal (arjun@openforce.net)
    @cvs-id $Id$
} -query {
}

array set config $cf

set shaded_p $config(shaded_p)
set list_of_package_ids $config(package_id)
set one_instance_p [ad_decode [llength $list_of_package_ids] 1 1 0]

template::list::create -name faqs -multirow faqs -key faq_id -no_data [_ faq-portlet.no_faqs] -elements {
    faq_name {
        label "[_ faq-portlet.name]"
        link_url_col faq_url
    }
    parent_name {
        label "[_ faq-portlet.group]"
    }
}

db_multirow -extend { faq_url parent_name url } faqs select_faqs [subst {
    select f.faq_id,
           f.faq_name,
           o.context_id as package_id
      from faqs f,
           acs_objects o
    where f.faq_id = o.object_id
      and not f.disabled_p
      and o.object_id in ([join $list_of_package_ids ", "])
    order by lower(faq_name)
}] {
    set node [site_node::get_from_object_id -object_id $package_id]
    set url [dict get $node url]
    set parent_node [site_node::get -node_id [dict get $node parent_id]]
    set parent_name [acs_object_name [dict get $parent_node object_id]]
    
    set faq_url [export_vars -base "${url}one-faq" {faq_id}]
}

if {${faqs:rowcount} == 1} {
    set faq_name [lindex [array get {faqs:1} faq_name] 1]
    set parent_name [lindex [array get {faqs:1} parent_name] 1]
    set faq_url [lindex [array get {faqs:1} url] 1]
    set faq_id [lindex [array get {faqs:1} faq_id] 1]

    db_multirow questions select_faq_questions {
        select entry_id,
               faq_id,
               question,
               answer,
               sort_key 
        from faq_q_and_as 
        where faq_id = :faq_id
        order by sort_key
    }
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
