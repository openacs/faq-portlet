#
# /faq-portlet/www/faq-portlet.tcl
#
# distributed under the terms of the GNU GPL version 2
#
# arjun@openforce.net
#
# The logic for the faq portlet
#
# $Id$
# 



array set config $cf	

set shaded_p $config(shaded_p)

# Should be a list already! 
set list_of_package_ids $config(package_id)
set data ""


if {[llength $list_of_package_ids] == 1} {
    set one_instance_p 1
} else {
    set one_instance_p 0
}

foreach package_id $list_of_package_ids {

    if { [db_string faq_q_and_as_count_select {} ] != 0 } {
            
        set comm_name [site_nodes::get_parent_name \
                -instance_id $package_id
        ]

        set comm_url [dotlrn_community::get_url_from_package_id -package_id $package_id]

        append data "$comm_name<P><ul>"

        db_foreach faqs_select {} {
            append data "<li><a href=${comm_url}one-faq?faq_id=$faq_id>$faq_name</a><P>"
        }
        
        append data "</ul>"
        
    } elseif {$one_instance_p} {
        append data "<small>No FAQs available</small>"
    }
        
}
        
