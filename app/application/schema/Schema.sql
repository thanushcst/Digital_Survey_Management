CREATE DATABASE IF NOT EXISTS survey_managament_system;

USE survey_managament_system;

CREATE TABLE IF NOT EXISTS tbl_users ( 
    username varchar(255) NOT NULL COMMENT 'Username',
    phone_number varchar(20) COMMENT 'Phone number',
    user_uid varchar(20) NOT NULL COMMENT 'Auto generated internal alphanumeric identifier',
    last_login int(11) COMMENT 'Last login',
    user_id int(12) NOT NULL AUTO_INCREMENT ,
    name varchar(255) NOT NULL COMMENT 'Full name',
    modified_date int (10) COMMENT 'Modified Date',
    created_date int (10) COMMENT 'Created Date',
    created_by int(20) COMMENT 'Created By',
    modified_by int(20) COMMENT 'Modified By',
    last_unsuccessful_login int(11) COMMENT 'Last unsuccessful login',
    status int(5) COMMENT 'Status',
    groups varchar(255) COMMENT 'Groups',
    persistent_token varchar(50) COMMENT 'Persistent token',
    token_expire_in int(11) COMMENT 'Token expire in',
    role varchar(50) NOT NULL COMMENT 'User role',
    password varchar(255) NOT NULL COMMENT 'Password',
    email varchar(255) NOT NULL COMMENT 'Email',
    UNIQUE KEY uk_users_username (username),
    PRIMARY KEY (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS tbl_organization ( 
    organization_id int(12) NOT NULL AUTO_INCREMENT ,
    organization_name varchar(255) NOT NULL COMMENT 'Organization Name',
    UNIQUE KEY uk_users_username (organization_name),
    PRIMARY KEY (organization_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS tbl_input_type ( 
    input_type_id int(12) NOT NULL AUTO_INCREMENT ,
    input_type_name varchar(255) NOT NULL COMMENT 'Input Type',
    UNIQUE KEY uk_users_username (input_type_name),
    PRIMARY KEY (input_type_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS tbl_unit_of_measures ( 
    unit_of_measures_id int(12) NOT NULL AUTO_INCREMENT ,
    unit_of_measures_name varchar(255) NOT NULL COMMENT 'Unit of Measure Name',
    UNIQUE KEY uk_users_username (unit_of_measures_name),
    PRIMARY KEY (unit_of_measures_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS tbl_user_groups ( 
    groups varchar(255) COMMENT 'Groups',
    user_group_id int(12) NOT NULL AUTO_INCREMENT ,
    user_id int(12) NOT NULL COMMENT 'User id',
    modified_date int (10) COMMENT 'Modified Date',
    created_by int(20) COMMENT 'Created By',
    created_date int (10) COMMENT 'Created Date',
    modified_by int(20) COMMENT 'Modified By',
    PRIMARY KEY (user_group_id),
    FOREIGN KEY (user_id) REFERENCES tbl_users(user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS tbl_survey_header ( 
    survey_name varchar(255) COMMENT 'Sections Name',
    instructions varchar(250) COMMENT 'Sections Title' ,
    survey_header_id int(12) NOT NULL AUTO_INCREMENT ,
    organization_id int(12) NOT NULL COMMENT 'Organization Header' ,
    sections_subheading varchar(250) COMMENT 'Sections Subheading',
    PRIMARY KEY (survey_header_id),
    FOREIGN KEY (organization_id) REFERENCES tbl_organization(organization_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS tbl_survey_sections ( 
    sections_name varchar(255) COMMENT 'Sections Name',
    sections_title varchar(250) COMMENT 'Sections Title' ,
    survey_sections_id int(12) NOT NULL AUTO_INCREMENT ,
    survey_header_id int(12) NOT NULL COMMENT 'Sections Header' ,
    sections_subheading varchar(250) COMMENT 'Sections Subheading',
    sections_required_state BOOLEAN COMMENT 'Sections Status' ,
    PRIMARY KEY (survey_sections_id),
    FOREIGN KEY (survey_header_id) REFERENCES tbl_survey_header(survey_header_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS tbl_user_survey_sections ( 
    user_survey_sections_id int(12) NOT NULL AUTO_INCREMENT,
    user_id int(12) NOT NULL COMMENT 'User id',
    survey_sections_id int(12) NOT NULL COMMENT 'Survey Sections id',
    modified_date int (10) COMMENT 'Modified Date',
    PRIMARY KEY (user_survey_sections_id),
    FOREIGN KEY (user_id) REFERENCES tbl_users(user_id),
    FOREIGN KEY (survey_sections_id) REFERENCES tbl_survey_sections(survey_sections_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS tbl_option_group ( 
    option_group_id int(12) NOT NULL AUTO_INCREMENT ,
    option_group_name varchar(255) NOT NULL COMMENT 'Option Group Name',
    UNIQUE KEY uk_users_username (option_group_name),
    PRIMARY KEY (option_group_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS tbl_option_choices ( 
    option_choice_id int(12) NOT NULL AUTO_INCREMENT ,
    option_group_id int(12) NOT NULL COMMENT 'Options Group id' ,
    option_choice_name varchar(255) NOT NULL COMMENT 'Option Choice Name',
    UNIQUE KEY uk_users_username (option_choice_name),
    PRIMARY KEY (option_choice_id),
    FOREIGN KEY (option_group_id) REFERENCES tbl_option_group(option_group_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


CREATE TABLE IF NOT EXISTS tbl_questions ( 
    questions_id int(12) NOT NULL AUTO_INCREMENT ,
    survey_sections_id int(12) NOT NULL COMMENT 'Survey Sections id' ,
    input_type_id int(12) NOT NULL COMMENT 'Input Type id' ,
    questions_name varchar(255) NOT NULL COMMENT 'Questions Name',
    questions_subtext varchar(255) COMMENT 'Questions Subtext',
    answer_required_state BOOLEAN NOT NULL COMMENT 'State',
    modified_date int (10) COMMENT 'Modified Date',
    created_date int (10) COMMENT 'Created Date',
    created_by int(20) COMMENT 'Created By',
    modified_by int(20) COMMENT 'Modified By',
    option_group_id int(12) NOT NULL COMMENT 'Option Group id' ,
    UNIQUE KEY uk_users_username (questions_name),
    allow_multiple_answer_state BOOLEAN NOT NULL COMMENT 'Multiple Option State',
    PRIMARY KEY (questions_id),
    FOREIGN KEY (survey_sections_id) REFERENCES tbl_survey_sections(survey_sections_id),
    FOREIGN KEY (input_type_id) REFERENCES tbl_input_type(input_type_id),
    FOREIGN KEY (option_group_id) REFERENCES tbl_option_group(option_group_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS tbl_question_options ( 
    question_options_id int(12) NOT NULL AUTO_INCREMENT ,
    questions_id int(12) NOT NULL COMMENT 'Question id' ,
    option_choice_id int(12) NOT NULL COMMENT 'Question Choice id' ,
    PRIMARY KEY (question_options_id),
    FOREIGN KEY (questions_id) REFERENCES tbl_questions(questions_id),
    FOREIGN KEY (option_choice_id) REFERENCES tbl_option_choices(option_choice_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS tbl_answers ( 
    answer_id int(12) NOT NULL AUTO_INCREMENT ,
    user_id int(12) NOT NULL COMMENT 'User id' ,
    question_options_id int(12) NOT NULL COMMENT 'Question id' ,
    answer_number int(12) NOT NULL COMMENT 'anwser Numberic' ,
    answer_text varchar(255) NOT NULL COMMENT 'Full name',
    answer_state BOOLEAN NOT NULL COMMENT 'Answer State',
    modified_date int (10) COMMENT 'Modified Date',
    created_date int (10) COMMENT 'Created Date',
    created_by int(20) COMMENT 'Created By',
    modified_by int(20) COMMENT 'Modified By',
    latitute varchar(255) COMMENT 'Latitute',
    longitute varchar(255) COMMENT 'Longitute',
    unit_of_measures_id int(12) NOT NULL COMMENT 'Unit of Measure id' ,
    PRIMARY KEY (answer_id),
    FOREIGN KEY (user_id) REFERENCES tbl_users(user_id),
    FOREIGN KEY (question_options_id) REFERENCES tbl_question_options(question_options_id),
    FOREIGN KEY (unit_of_measures_id) REFERENCES tbl_unit_of_measures(unit_of_measures_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;