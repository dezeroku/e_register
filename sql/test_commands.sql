SELECT add_user('testUser','testPassword','teacher',1); --should return true (correct)
SELECT add_user('testUser','testPassword','teacher',1); --should return false (duplicate)
--SELECT add_user('testUser2','testPassword','teacher',1); --should return true (correct) --TODO: this should return false, as id duplicates first entry, there should be trigger for this
SELECT add_user('testUser2','testPassword','teacher',2); --should return true (correct)
SELECT add_user('testUser3','testPassword','teacher',3); --should return true (correct)
SELECT add_user('testStudent','testPassword','student',1); --should return true (correct)

SELECT check_login_data('testUser','testPassword', 'teacher'); --should return true,teacher,1
SELECT check_login_data('testUserFailed','testPassword', 'parent'); --should return false,-,-
SELECT check_login_data('testUser','testPassword', 'parent'); --should return false,-,- (bad user_type)

SELECT add_semester('summer',2018); --should return 1 (correct)
SELECT add_semester('winter',2018); --should return 2 (correct)
SELECT add_semester('winter',2018); --should return -1 (duplicate)

SELECT get_address_id('Paradise City','Imagined','12a','3','01-231'); --should return 1 (correct, create)
SELECT get_address_id('City Wok','Baker Street','32c','3','01-232'); --should return 2 (correct, create)
SELECT get_address_id('Paradise City','Imagined','12a','3','01-231'); --should return 1 (correct, find)

SELECT add_subject('Science'); --should return 1 (correct)
SELECT add_subject('Math'); --should return 2 (correct)
SELECT add_subject('Science'); --should return -1 (duplicate)

SELECT add_school('dummySchool',1,'LO','standard'); --should return 1 (correct)
SELECT add_school('Hogwart',2,'TECH','standard'); --should return 2 (correct)
SELECT add_school('dummySchool',1,'LO','standard'); --should return -1 (duplicate)

SELECT add_teacher(1,'tempFor','tempSur','mgr.','male','Jan-18-1923'); --should return 1 (correct)
SELECT add_teacher(1,'tempFor','tempSur','mgr.','male','Jan-18-1924'); --should return 2 (correct)
SELECT add_teacher(1,'tempFor','tempSur','mgr.','male','Jan-18-1923'); -- should return -1 (duplicate)

SELECT add_teacher_to_school(1,1); --should return t (correct)
SELECT add_teacher_to_school(1,2); --should return t (correct)
SELECT add_teacher_to_school(1,1); --should return f (duplicate)
SELECT add_teacher_to_school(2,1); --should return t (correct)
SELECT add_teacher_to_school(11,1); --should return f (non-existing teacher)
SELECT add_teacher_to_school(1,21); --should return f (non-existing school)

SELECT add_school_admin(1,1); --should return t (existing teacher to existing school)
SELECT add_school_admin(1,1); --should return f (duplicate)
SELECT add_school_admin(1,23); --should return f (existing teacher to not existing school)
SELECT add_school_admin(23, 1); --should return f (not-existing teacher to existing school)
SELECT add_school_admin(23, 23); --should return f (not-existing teacher to not-existing school)

SELECT add_class(1,1,'Oct-1-2007','Oct-1-2010','a',1); --should return 1 (correct)
SELECT add_class(1,1,'Oct-1-2009','Oct-1-2012','c',1); --should return 1 (correct)
SELECT add_class(1,1,'Oct-1-2007','Oct-1-2010','a',1); --should return -1 (duplicate)

SELECT add_student(1,1,1,'John','Snow','male','Jan-12-1998'); --should return 1 (correct)
SELECT add_student(1,1,1,'John','Snow','male','Jan-12-1998'); --should return 2 (correct, two students in same class with same names and same born_date can happen)
SELECT add_student(23,1,1,'Felicia','Snow','female','Jan-12-1998'); --should return -1 (non-existing school)
SELECT add_student(1,23,1,'Felicia','Snow','female','Jan-12-1998'); --should return -1 (non-existing class)
SELECT add_student(1,1,23,'Felicia','Snow','female','Jan-12-1998'); --should return -1 (non-existing address)

SELECT add_grade(1,1,1,'4.0'); --should return t (correct)
SELECT add_grade(1,1,8,'3.0'); --should return f (non-existing subject)
SELECT add_grade(1,8,1,'3.0'); --should return f (non-existing teacher)
SELECT add_grade(8,1,1,'3.0'); --should return f (non-existing student)

SELECT add_lesson(1,1,'08:00','08:45','Monday'); --should return 1 (correct)
SELECT add_lesson(1,1,'08:00','08:45','Monday'); --should return 2 (duplicate, but allowed)
SELECT add_lesson(1,5,'08:00','08:45','Monday'); --should return -1 (non-existing school)
SELECT add_lesson(2,5,'08:00','08:45','Monday'); --should return -1 (non-existing subject)

SELECT add_teacher_to_lesson(1,1); --should return t (correct)
SELECT add_teacher_to_lesson(1,1); --should return f (duplicate)

SELECT check_if_teacher_is_school_admin(1); --should return 1
SELECT check_if_teacher_is_school_admin(2); --should return -1
SELECT check_if_teacher_is_school_admin(0); --should return -1

SELECT add_student_to_lesson(1, 1); --should return true (correct)
SELECT add_student_to_lesson(1, 2); --should return true (correct)
SELECT add_student_to_lesson(1, 10); --should return false (non-existing student)
SELECT add_student_to_lesson(10, 1); --should return false (non-existing lesson)

SELECT add_class_to_lesson(1, 10); --should return false (incorrect class_id)
SELECT add_class_to_lesson(10, 1); --should return false (incorrect lesson_id)
SELECT add_class_to_lesson(1, 1); --should return true (correct)
SELECT add_class_to_lesson(1, 1); --should return false (duplicate)
SELECT add_class_to_lesson(1, 2); --should return true (correct)

SELECT add_warning(1,1,'very bad student!'); --should return true (correct)
SELECT add_warning(1,12,'very bad student!'); --should return false (incorrect teacher_id)
SELECT add_warning(12,1,'very bad student!'); --should return false (incorect student_id)

SELECT add_final_grade(1, 1, 1, 1); --should return true (everything is correct)
SELECT add_final_grade(1, 1, 1, 0); --should return false (incorrect grade (1-6)) 
SELECT add_final_grade(1, 1, 1, 8); --should return false (incorrect grade (1-6)) 
SELECT add_final_grade(1, 1, 1, 1); --should return false (duplicate)
SELECT add_final_grade(1, 1, 2, 1); --should return false (teacher is not connected with lesson TODO: WRITE TRIGGER FOR THAT)

SELECT add_final_grade_behaviour(1,1,2); --should return true (correct)
SELECT add_final_grade_behaviour(1,1,0); --should return false (ncorrect grade)
SELECT add_final_grade_behaviour(1,1,8); --should return false (incorrect grade)
SELECT add_final_grade_behaviour(1,1,2); --should return false (duplicate) 
SELECT add_final_grade_behaviour(1,2,2); --should return false (not a class educator) 

SELECT add_teacher_to_subject(1,1); --should return true (correct)
SELECT add_teacher_to_subject(1,1); --should return false (duplicate)
SELECT add_teacher_to_subject(1,11); --should return false (no such subject)
SELECT add_teacher_to_subject(11,1); --should return false (no such teacher)


--TODO: what if data cannot be added to Users because it breaks integration? at the moment loop will never end
SELECT add_new_user('Name','Surname','student',2); -- should return Name.Surname, random string
SELECT add_new_user('Name','Surname','student',2); -- should return Name.Surname1, random string
SELECT add_new_user('Name','Surname','student',2); -- should return Name.Surname2, random string

