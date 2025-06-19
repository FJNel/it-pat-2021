# School Portal System

**Developer:** Johan Nel  
**Grade:** 10-5  
**School:** Hoërskool Secunda  
**Year:** 2023  
**Project Type:** IT PAT (Practical Assessment Task)  
**Language:** Delphi 2010  
**Database:** Microsoft Access  

---

## Overview

The **School Portal System** is a desktop application designed to provide a secure and user-friendly login portal for learners, teachers, and administrators at a school. It features automated username generation, password strength validation, and multifactor authentication (OTP and Captcha) to ensure security. The system also includes role-specific functionalities tailored for each user type.

---

## Purpose

This application aims to:
- Automatically generate usernames for new accounts.
- Validate password strength during registration.
- Provide secure login with multifactor authentication (OTP or Captcha).
- Offer role-specific functionalities for learners, teachers, and administrators.
- Maintain logs for administrative oversight.

---

## Users & Roles

### Learner
- Register for an account with an automatically generated username.
- Log in using credentials and complete multifactor authentication.
- Calculate subject averages by entering marks and task weights.

### Teacher
- Register for an account with an automatically generated username.
- Log in using credentials and complete multifactor authentication.
- Calculate class averages by entering learner marks.

### Administrator
- Register for an account with an automatically generated username.
- Log in using credentials and optionally bypass multifactor authentication.
- Access and review log files for debugging and system monitoring.
- Navigate to learner and teacher panels for testing purposes.

---

## Database Design

- **UserLogin.mdb**: Stores user details, including usernames, passwords, first names, last names, birthdates, and user types (Learner, Teacher, Admin).

### Key Fields:
- `Username`: Automatically generated (e.g., MolL2006ain for Molly Bain).
- `Password`: User-defined, validated for strength.
- `User_Type`: Specifies role (L for Learner, T for Teacher, A for Admin).

---

## Key Features

- **Automated Username Generation**: Combines user details (e.g., first name initial, surname, birth year) to create unique usernames.
- **Password Strength Validation**: Ensures passwords meet security criteria (e.g., length, character diversity).
- **Multifactor Authentication**: Offers OTP (decoding challenge) or Captcha (text verification) for secure login.
- **Role-Specific Functionality**:
  - Learners: Calculate subject averages.
  - Teachers: Calculate class averages.
  - Admins: Access logs and test system functionality.
- **Logging**: Tracks user activities for administrative review.

---

## File Structure

- **Log Files**: Store user activities and system events.
- **Help Files**: Provide guidance for users (displayed when Help buttons are clicked).
- **Captcha Images**: Generated as `.png` files for verification purposes.

---

## Validation Highlights

- **Registration Validation**:
  - Ensures first names, surnames, and passwords meet length requirements.
  - Validates birthdates to ensure they are not in the future.
  - Checks password strength (must be "Medium" or "High").
- **Login Validation**:
  - Verifies username and password against the database.
  - Validates OTP or Captcha input during multifactor authentication.

---

## GUI Forms

### Form 1: Account Management
- **Panel 1**: Log in to an existing account.
- **Panel 2**: Register a new account with automated username generation and password strength validation.

### Form 2: Multifactor Authentication
- **Panel 1**: Choose between OTP or Captcha.
- **Panel 2**: Complete OTP challenge (decode a phrase into a number).
- **Panel 3**: Complete Captcha challenge (retype generated characters).

### Form 3: Role-Specific Functionality
- **Panel 1 (Learners)**: Calculate subject averages.
- **Panel 2 (Teachers)**: Calculate class averages.
- **Panel 3 (Admins)**: View log files and access learner/teacher panels.

---

## Resources & References

- **Database Setup**: Based on tutorials by Mr. Long ([YouTube Link](https://www.youtube.com/watch?v=RIv0XFQJaM8&list=PLxAS51iVMjv8Xl1FfV9GQ2dwhqttUrAT6&index=10)).
- **Captcha Generation**: Utilizes Delphi Canvas properties ([Embarcadero Documentation](https://docwiki.embarcadero.com/RADStudio/Sydney/en/Common_Properties_and_Methods_of_Canvas)).
- **Logging System**: Inspired by Mr. Long's tutorial ([YouTube Link](https://www.youtube.com/watch?v=bUpSl3fvPNs)).

---

## Premade Users (for Testing)

| Username     | Password      | First Name | Last Name | Birth Date | User Type |
|--------------|---------------|------------|-----------|------------|-----------|
| MolL2006ain  | BalinB@123!   | Molly      | Bain      | 2006/12/09 | L (Learner) |
| BeaT1985man  | Rahman@Nod!1  | Beatrice   | Rahman    | 1985/02/24 | T (Teacher) |
| JohA2005Nel  | H3llo@World!  | Johan      | Nel       | 2005/11/23 | A (Admin) |

---

## Setup Instructions

1. **Database Connection**:
   - Open `dmUserLogin_u` in Delphi.
   - Configure `ConUserDatabase` with the correct connection string pointing to `UserLogin.mdb`.
   - Ensure `tblData` is active (`Active Property = True`).

2. **Running the Program**:
   - Launch the application and use the premade accounts or register new ones.
   - Follow on-screen instructions for login and multifactor authentication.

---

This system provides a robust and secure way to manage user access and role-specific tasks within a school environment. For further assistance, refer to the Help buttons within the application or the provided documentation.
