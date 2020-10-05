ad_library {
    Automated tests.
    @author Mounir Lallali
    @creation-date 14 June 2005

}

aa_register_case -cats {web smoke} -libraries tclwebtest  tclwebtest_new_faq_portlet {

    Testing the creation a Faq from the portlet.

} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear
        # Login user
        array set user_info [twt::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Create new Faq
        set faq_name [ad_generate_random_string]
        set response [faq_portlet::twt::new $faq_name]
        aa_display_result -response $response -explanation {Webtest for creating a New Faq from the portlet}

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest  tclwebtest_delete_faq_portlet {

    Testing the process of creating and deleting a Faq from the portlet.

} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear
        # Login user
        array set user_info [twt::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Create a new Faq
        set faq_name [ad_generate_random_string]
        faq_portlet::twt::new $faq_name

        # Delete the faq
        set response [faq_portlet::twt::delete $faq_name]
        aa_display_result -response $response -explanation {Webtest for deleting a Faq}

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_disable_faq_portlet {

    Testing the process of creating and disabling a Faq.

} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear
        # Login user
        array set user_info [twt::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Create new faq
        set faq_name [ad_generate_random_string]
        faq_portlet::twt::new $faq_name

        # Disable the Faq
        set option "disable"
        set response [faq_portlet::twt::disable_enable $faq_name $option]
        aa_display_result -response $response -explanation {Webtest for disabling a Faq}

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_enable_faq_portlet {

    Testing the process of creating, disabling and enabling Faq.

} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear
        # Login user
        array set user_info [twt::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Create the Faq
        set faq_name [ad_generate_random_string]
        faq_portlet::twt::new $faq_name

        # Disable the faq
        set option "disable"
        faq_portlet::twt::disable_enable $faq_name $option

        # Enable the faq
        set option "enable"
        set response [faq_portlet::twt::disable_enable $faq_name $option]
        aa_display_result -response $response -explanation {Webtest for enabling a Faq}

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_edit_faq_portlet {

    Testing the process of creating and editing a Faq.

} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear
        # Login user
        array set user_info [twt::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Create a new faq
        set faq_name [ad_generate_random_string]
        faq_portlet::twt::new $faq_name

        # Edit the faq
        set new_faq_name [ad_generate_random_string]
        set response [faq_portlet::twt::edit_faq $faq_name $new_faq_name]
        aa_display_result -response $response -explanation {Webtest for editing a Faq}

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_new_Q_A_faq_portlet {

    Testing the process of create a Faq and create a new Q&A.

} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear
        # Login user
        array set user_info [twt::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Create a new faq
        set faq_name [ad_generate_random_string]
        faq_portlet::twt::new $faq_name

        # Create a new Question_Answer
        set question [ad_generate_random_string]
        set answer [ad_generate_random_string]
        set response [faq_portlet::twt::new_Q_A $faq_name $question $answer]
        aa_display_result -response $response -explanation {Webtest for creating a New Question in a dotLRN Faq}

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_delete_Q_A_faq_portlet {

    Testing the process of create a faq, create a Q&A and then delete the Q&A.

} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear
        # Login user
        array set user_info [twt::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Create a new faq
        set faq_name [ad_generate_random_string]
        faq_portlet::twt::new $faq_name

        # Create a new Question_Answer
        set question [ad_generate_random_string]
        set answer [ad_generate_random_string]
        faq_portlet::twt::new_Q_A $faq_name $question $answer

        # Delete the Question_Answer
        set response [faq_portlet::twt::delete_Q_A $faq_name $question]
        aa_display_result -response $response -explanation {Webtest for deleting a Question in a Faq}

        twt::user::logout
    }
}

aa_register_case -procs {
        faq_admin_portlet::link
        faq_portlet::link
        faq_admin_portlet::get_pretty_name
        faq_portlet::get_pretty_name
    } -cats {
        api
        production_safe
    } faq_portlet_links_names {
        Test diverse link and name procs.
} {
    aa_equals "FAQ admin portlet link"          "[faq_admin_portlet::link]" ""
    aa_equals "FAQ portlet link"                "[faq_portlet::link]" ""
    aa_equals "FAQ admin portlet pretty name"   "[faq_admin_portlet::get_pretty_name]" "#faq-portlet.admin_pretty_name#"
    aa_equals "FAQ portlet pretty name"         "[faq_portlet::get_pretty_name]" "#faq-portlet.pretty_name#"
}

aa_register_case -procs {
        faq_portlet::add_self_to_page
        faq_portlet::remove_self_from_page
        faq_admin_portlet::add_self_to_page
        faq_admin_portlet::remove_self_from_page
    } -cats {
        api
    } faq_portlet_add_remove_from_page {
        Test add/remove portlet procs.
} {
    #
    # Helper proc to check portal elements
    #
    proc portlet_exists_p {portal_id portlet_name} {
        return [db_0or1row portlet_in_portal {
            select 1 from dual where exists (
              select 1
                from portal_element_map pem,
                     portal_pages pp
               where pp.portal_id = :portal_id
                 and pp.page_id = pem.page_id
                 and pem.name = :portlet_name
            )
        }]
    }
    #
    # Start the tests
    #
    aa_run_with_teardown -rollback -test_code {
        #
        # Create a community.
        #
        # As this is running in a transaction, it should be cleaned up
        # automatically.
        #
        set community_id [dotlrn_community::new -community_type dotlrn_community -pretty_name foo]
        if {$community_id ne ""} {
            aa_log "Community created: $community_id"
            set portal_id [dotlrn_community::get_admin_portal_id -community_id $community_id]
            set package_id [dotlrn::instantiate_and_mount $community_id [faq_portlet::my_package_key]]
            #
            # faq_portlet
            #
            set portlet_name [faq_portlet::get_my_name]
            #
            # Add portlet.
            #
            faq_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id -param_action ""
            aa_true "Portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Remove portlet.
            #
            faq_portlet::remove_self_from_page -portal_id $portal_id -package_id $package_id
            aa_false "Portlet is in community portal after removal" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Add portlet.
            #
            faq_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id -param_action ""
            aa_true "Portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # admin_portlet
            #
            set portlet_name [faq_admin_portlet::get_my_name]
            #
            # Add portlet.
            #
            faq_admin_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id
            aa_true "Admin portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Remove portlet.
            #
            faq_admin_portlet::remove_self_from_page $portal_id
            aa_false "Admin portlet is in community portal after removal" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Add portlet.
            #
            faq_admin_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id
            aa_true "Admin portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
        } else {
            aa_error "Community creation failed"
        }
    }
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
