# faq-portlet/tcl/faq-portlet-procs.tcl

ad_library {

Procedures to support the file-storage portlet

Copyright Openforce, Inc.
Licensed under GNU GPL v2 

@creation-date September 30 2001
@author arjun@openforce.net 
@cvs-id $Id$

}

namespace eval faq_portlet {

    ad_proc -private my_name {
    } {
    return "faq-portlet"
    }

    ad_proc -public add_self_to_page { 
	page_id 
	community_id
    } {
	Adds a faq PE to the given page with the community_id
	being opaque data in the portal configuration.
    
	@return element_id The new element's id
	@param page_id The page to add self to
	@param community_id The community with the folder
	@author arjun@openforce.net
	@creation-date Sept 2001
    } {
	# Tell portal to add this element to the page
	set element_id [portal::add_element $page_id [my_name]]
	
	# The default param "community_id" must be configured
	set key "community_id"
	portal::set_element_param $element_id $key $community_id

	return $element_id
    }

    ad_proc -public show { 
	 cf 
    } {
	 Display the PE
    
	 @return HTML string
	 @param cf A config array
	 @author arjun@openforce.net
	 @creation-date Sept 2001
    } {

	array set config $cf	

	# things we need in the config: community_id

	ns_log notice "AKS55 got here"

	# a big-time query from file-storage
	set query " select faq_id, faq_name
	from acs_objects o, faqs f
	where object_id = faq_id
        and context_id = $config(community_id)
	order by faq_name"
	
	set data ""
	set rowcount 0

	db_foreach select_files_and_folders $query {
	    append data "<tr><td>$faq_id</td><td>$faq_name</td></tr>"
	    incr rowcount
	} 

	set template "
	<table width=100% border=1 cellpadding=2 cellspacing=2>
	<tr>
	<td bgcolor=#cccccc>faq_id</td>
	<td bgcolor=#cccccc>Name</td>
	</tr>
	$data
	</table>"

	ns_log notice "AKS56 got here $rowcount"

	if {!$rowcount} {
	    set template "<i>No faqs available</i>"
	}

	set code [template::adp_compile -string $template]

	set output [template::adp_eval code]
	ns_log notice "AKS57 got here $output"
	
	return $output

    }

    ad_proc -public remove_self_from_page { 
	portal_id 
	community_id 
    } {
	  Removes a faq PE from the given page 
    
	  @param page_id The page to remove self from
	  @param community_id
	  @author arjun@openforce.net
	  @creation-date Sept 2001
    } {
	# Find out the element_id that corresponds to this community_id

	# XXX - fixme - the PE needs to find out it's own ID based on
	# the datasource_id. Need a call in NPP to do this
	
	if { [db0or1row get_element_id "
	select pem.element_id as element_id
	from portal_element_parameters pep, 
	portal_element_map pem
	where pem.portal_id = $portal_id and
	pep.element_id = pem.element_id and
	pep.key = 'community_id' and
	pep.value = $community_id
	"]  } {
	    
	    # delete the params
	    # delete the element from the map
	    ns_log Notice "AKS58 faq-portlet-procs delete called"

	 } else {
	     ad_return_complaint 1 "faq_portlet::remove_self_from_page: Invalid portal_id  and/or community_id given."
	     ad_script_abort
	 }

	 # this call removes the PEs params too
	 set element_id [portal::remove_element {$portal_id $element_id}]
     }
 }

 

