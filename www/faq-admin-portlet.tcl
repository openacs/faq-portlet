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
    return -code error [_ faq-portlet.one_admin_faq]
}        

set package_id [lindex $list_of_package_ids 0]

db_multirow faqs select_faqs {
    select f.faq_id, 
           f.faq_name
    from faqs f,
         acs_objects o
    where f.faq_id = o.object_id
    and o.context_id = :package_id
}

set url [lindex [site_node::get_url_from_object_id -object_id $package_id] 0]

ad_return_template
