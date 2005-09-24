ad_library {
    Automated tests.
    @author Mounir Lallali
    @creation-date 14 June 2005

}

aa_register_case -cats {web smoke} -libraries tclwebtest  webtest_new_faq_portlet {

    Testing the creation a Faq from the portlet.

} {
	aa_run_with_teardown -test_code {
		# Create new Faq
		set faq_name [ad_generate_random_string]
		set response [faq_portlet::twt::new $faq_name] 
 		aa_display_result -response $response -explanation {Webtest for creating a New Faq from the portlet}

       }
}	

aa_register_case -cats {web smoke} -libraries tclwebtest  webtest_delete_faq_portlet {

    Testing the process of creating and deleteing a Faq from the portlet.

} {
	aa_run_with_teardown -test_code {
		# Create new Faq
		set faq_name [ad_generate_random_string]
		faq_portlet::twt::new $faq_name
                # Deleteing the faq 
		set response [faq_portlet::twt::delete $faq_name]
		aa_display_result -response $response -explanation {Webtest for deleting a Faq}
		
        } 
}

aa_register_case -cats {web smoke} -libraries tclwebtest webtest_disable_faq_portlet {

    Testing the process of creating and disableing a Faq. 

} {
	aa_run_with_teardown -test_code {
		# Create new faq 
		set faq_name [ad_generate_random_string]
		faq_portlet::twt::new $faq_name
                # Disable the Faq
		set option "disable"		
		set response [faq_portlet::twt::disable_enable $faq_name $option]
		aa_display_result -response $response -explanation {Webtest for disabling a Faq}
        }
}

aa_register_case -cats {web smoke} -libraries tclwebtest webtest_enable_faq_portlet {

    Testing the process of creating, desableing and enableing Faq. 

} {
	aa_run_with_teardown -test_code {
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
	    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest webtest_edit_faq_portlet {

    Testing the process of creating and editing a Faq. 

} {
	aa_run_with_teardown -test_code {
		# Creating the new faq
		set faq_name [ad_generate_random_string]
		set new_faq_name [ad_generate_random_string]
		faq_portlet::twt::new $faq_name 
                # Edit the faq
		set response [faq_portlet::twt::edit_faq $faq_name $new_faq_name]
		aa_display_result -response $response -explanation {Webtest for editing a Faq}
        } 
}

aa_register_case -cats {web smoke} -libraries tclwebtest webtest_new_Q_A_faq_portlet {

    Testing the process of create a Faq and create a new Q&A. 

} {
	aa_run_with_teardown -test_code {  
		set faq_name [ad_generate_random_string]
		set question [ad_generate_random_string]
		set answer [ad_generate_random_string]

		faq_portlet::twt::new $faq_name
	        set response [faq_portlet::twt::new_Q_A $faq_name $question $answer]
	        aa_display_result -response $response -explanation {Webtest for creating a New Question in a dotLRN Faq}
        }
}

aa_register_case -cats {web smoke} -libraries tclwebtest webtest_delete_Q_A_faq_portlet {

    Testing the process of create a faq, create a Q&A and  then delete the Q&A.

    } {
        aa_run_with_teardown -test_code {
	    set faq_name [ad_generate_random_string]
	    set question [ad_generate_random_string]
	    set answer [ad_generate_random_string]

            faq_portlet::twt::new $faq_name
	    faq_portlet::twt::new_Q_A $faq_name $question $answer
	    set response [faq_portlet::twt::delete_Q_A $faq_name $question]
	    aa_display_result -response $response -explanation {Webtest for deleting a Question in a Faq}
        }
    }
