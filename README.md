# University Admission Database (university_admission_db)

## Overview

The University Admission Database is designed to manage the complete admission process of a university. It covers applicant registration, academic records, department information, admission applications, admission test results, merit lists, subject allocation, and final enrollment. The database provides a centralized system for storing and managing admission-related information efficiently and accurately.

## Features

### Applicant Management

* Stores personal information of applicants.
* Maintains contact details, gender, date of birth, and address.
* Generates unique applicant records.

### Academic Details

* Stores SSC and HSC academic information.
* Maintains GPA, board, institution, roll number, registration number, and passing year.
* Ensures accurate academic qualification records.

### Admission Application

* Records admission applications submitted by applicants.
* Links applicants to their preferred departments.
* Tracks application status and submission details.

### Admission Test & Results

* Stores admission test information and schedules.
* Records applicant scores and examination performance.
* Generates merit rankings based on results.

### Merit List Management

* Maintains selected and waiting candidate lists.
* Supports merit-based admission decisions.

### Subject Allocation

* Stores applicants' department preferences.
* Allocates departments according to merit position and seat availability.
* Maintains final allocation records.

### Enrollment Management

* Stores information of admitted students.
* Generates roll numbers and registration numbers.
* Maintains enrollment records for academic sessions.

## Database Schema

* Applicant – Stores applicant information.
* AcademicDetails – Stores SSC and HSC details.
* Application – Tracks admission applications.
* AdmissionTest – Stores examination details.
* Result – Stores admission test scores and rankings.
* MeritList – Maintains merit-based selection records.
* SubjectAllocation – Stores department allocation information.
* Enrollment – Stores final admitted student records.

## Data Integrity & Constraints

* Primary keys uniquely identify each record.
* Foreign key relationships ensure proper linkage between tables.
* Unique constraints prevent duplicate records.
* Check constraints validate GPA and other numerical values.
* NOT NULL constraints ensure required information is provided.
* Referential integrity maintains database consistency.
  
