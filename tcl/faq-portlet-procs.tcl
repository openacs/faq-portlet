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
    return "faq_portlet"
    }

    ad_proc -public get_pretty_name {
    } {
	return "Frequently Asked Questions"
    }

    ad_proc -public link {
    } {
	return "faq"
    }

    ad_proc -public add_self_to_page { 
	portal_id 
	package_id
    } {
	Adds a faq PE to the given page with the package_id
	being opaque data in the portal configuration.
    
	@return element_id The new element's id
	@param portal_id The page to add self to
	@param package_id the id of the faq package for this community
	@author arjun@openforce.net
	@creation-date Sept 2001
    } {
	# Find out if faq already exists on this portal page
	set element_id_list \
                [portal::get_element_ids_by_ds $portal_id [my_name]]

	if {[llength $element_id_list] == 0} {
	    # Tell portal to add this element to the page
	    set element_id [portal::add_element $portal_id [my_name]]
	    # There is already a value for the param which must be overwritten
	    portal::set_element_param $element_id package_id $package_id
	    set package_id_list [list]
	} else {
	    set element_id [lindex $element_id_list 0]
	    # There are existing values which should NOT be overwritten
	    portal::add_element_param_value \
                    -element_id $element_id \
                    -key package_id \
                    -value $package_id
	}

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

        set query "select f.faq_id, 
        f.faq_name, 
        entry_id, 
        question
	from acs_objects o, faqs f, faq_q_and_as qa
	where object_id = f.faq_id
        and context_id = :package_id
        and qa.faq_id(+) = f.faq_id"
	
	# Should be a list already! 
	set list_of_package_ids $config(package_id)

        if { $config(shaded_p) == "t" } {
            set data ""
            set template ""
        } else {
            # not shaded
            set template "
            <table width=100% border=0 cellpadding=2 cellspacing=2>
            "

            foreach package_id $list_of_package_ids {
        
                if { [db_string count_faqs "select count(*) as count from faq_q_and_as, acs_objects where context_id = :package_id and object_id=faq_id" ] != 0 } {
                    
                    # aks fold into site_nodes:: or dotlrn_community
                    set comm_object_id [db_string select_name "select object_id from site_nodes where node_id= (select parent_id from site_nodes where object_id=:package_id)" ]
                    
                    set name [db_string select_pretty_name "
                    select instance_name 
                    from apm_packages
                    where package_id= :comm_object_id "]
                    
                    append template "<tr><td colspan=2><a href=[dotlrn_community::get_url_from_package_id -package_id $package_id]><b>$name</b> FAQs</a></td></tr>"
                    db_foreach select_faqs $query {
                        append template "<tr><td>&nbsp;&nbsp;<a href=[dotlrn_community::get_url_from_package_id -package_id $package_id]one-faq?faq_id=$faq_id>$faq_name</a></td></tr>"
                    }
                } else {
                    # workspace no faqs
                    set template "<table border=0 cellpadding=2 cellspacing=2 width=100%><tr><td><small>No FAQs available</small></td></tr>"
                }
            }
            append template "</table>"
        }
        
        set code [template::adp_compile -string $template]
    
        set output [template::adp_eval code]
        
        return $output
        
    }


    ad_proc -public edit { 
	nothing here
    } {
	return ""
    }

    ad_proc -public remove_self_from_page { 
	portal_id 
	package_id 
    } {
	  Removes a faq PE from the given page 
    
	  @param portal_id The page to remove self from
	  @param package_id
	  @author arjun@openforce.net
	  @creation-date Sept 2001
    } {
	# get the element IDs (could be more than one!)
	set element_ids [portal::get_element_ids_by_ds $portal_id [my_name]]
        
	db_transaction {
	    foreach element_id $element_ids {
		# Highly simplified (ben)
		portal::remove_element_param_value -element_id $element_id -key package_id -value $package_id

		# Check if we should really remove the element
		if {[llength [portal::get_element_param_list -element_id $element_id -key package_id]] == 0} {
		    portal::remove_element $element_id
		}
	    }
	}
    }

    ad_proc -public make_self_available { 
 	portal_id 
    } {
 	Wrapper for the portal:: proc
 	
 	@param portal_id
 	@author arjun@openforce.net
 	@creation-date Nov 2001
    } {
 	portal::make_datasource_available \
 		$portal_id [portal::get_datasource_id [my_name]]
    }

    ad_proc -public make_self_unavailable { 
	portal_id 
    } {
	Wrapper for the portal:: proc
	
	@param portal_id
	@author arjun@openforce.net
	@creation-date Nov 2001
    } {
	portal::make_datasource_unavailable \
		$portal_id [portal::get_datasource_id [my_name]]
    }

}



 

