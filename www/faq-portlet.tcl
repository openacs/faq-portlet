# faq-portlet/www/faq-portlet.tcl

ad_page_contract {
    The logic for the faq portlet.

    @creation-user Arjun Sanyal (arjun@openforce.net)
    @version $Id$
} -query {
}

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

if {[ad_parameter community_level_p] == 1} {
# if i'm in a comm, have the list UI

    foreach package_id $list_of_package_ids {

        if { [db_string faq_q_and_as_count_select {} ] != 0 } {

            set comm_name [site_nodes::get_parent_name \
                    -instance_id $package_id
            ]

            set comm_url [dotlrn_community::get_url_from_package_id -package_id $package_id]

            set f_check [db_0or1row faqs_check {}]

            if {!$one_instance_p && $f_check} {
                append data "<li>$comm_name"
                append data "<ul>"
            }

            db_foreach faqs_select {} {
                append data "<li><a href=${comm_url}one-faq?faq_id=$faq_id>$faq_name</a><br>"
            }

            if {!$one_instance_p && $f_check} {
                append data "</ul>"
            }

        }
    }

} else {
    # i'm at /dotlrn, so have the table UI, hack

    #
    # this seems broken, but it was working ystr - aks 3/18
    #



    set one_instance_p 1
    set data ""
    set data_start "<table border=\"0\" bgcolor=\"white\" cellpadding=\"2\" cellspacing=\"3\" width=\"100%\">
    <tr>
                <td><strong>Name</strong></td>
                <td><strong>Group</strong></td>
    </tr>"

    foreach package_id $list_of_package_ids {

        set comm_url [dotlrn_community::get_url_from_package_id -package_id $package_id]

        set comm_name [site_nodes::get_parent_name \
                -instance_id $package_id
        ]

        set count 0

        db_foreach faqs_select {} {

            if {[expr $count % 2] == 0} {
                append data "<tr><td bgcolor=#ececec><a href=${comm_url}one-faq?faq_id=$faq_id>$faq_name</a></td><td bgcolor=#ececec>$comm_name</td></tr>"
            } else {
                append data "<tr><td><a href=${comm_url}one-faq?faq_id=$faq_id>$faq_name</a></td><td>$comm_name</td></tr>"
            }

            incr count
        }
    }

    set data_end "</table>"

    if {$count != 0} {
        append $data_start $data $data_end
    }


}

# portlets shouldn't disappear anymore (ben)
if {[empty_string_p $data]} {
    set no_faqs_p "t"
} else {
    set no_faqs_p "f"
}
