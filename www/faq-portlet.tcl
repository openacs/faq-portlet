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


foreach package_id $list_of_package_ids {

#    ad_return_complaint 1 "aks1 [db_string faq_q_and_as_count_select {} ] "

    if { [db_string faq_q_and_as_count_select {} ] != 0 } {
            
        set comm_name [site_nodes::get_parent_name \
                -instance_id $package_id
        ]

        set comm_url [dotlrn_community::get_url_from_package_id -package_id $package_id]

        append data "$comm_name<P>"

        db_foreach faqs_select {} {
            append data "&nbsp;&nbsp;<a href=${comm_url}one-faq?faq_id=$faq_id>$faq_name</a><P>"
        }
    } else {
            # workspace no faqs
            set data "<small>No FAQs available</small>"
    }
}
        
