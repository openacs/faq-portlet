ad_page_contract {
    The display logic for the FAQ admin portlet
    
    @author Ben Adida (ben@openforce)
    @cvs_id $Id$
} -properties {
    
}

# Configuration
array set config $cf	

# Should be a list already! 
set list_of_package_ids $config(package_id)

if {[llength $list_of_package_ids] > 1} {
    # We have a problem!
    return -code error "There should be only one instance of FAQ for admin purposes"
}        

set package_id [lindex $list_of_package_ids 0]

db_multirow faqs select_faqs "select f.faq_id, 
f.faq_name from
faqs f, acs_objects o
where faq_id= object_id and context_id = :package_id"
	
set url [dotlrn_community::get_url_from_package_id -package_id $package_id]

ad_return_template
