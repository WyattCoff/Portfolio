//Wyatt Coff
//Date: 15/06/2023
//assignment: Form Validation


//Pseudocode
//1. Define your function as validateForm()
//2. Create a new date object and get the current month and year (for credit card).
//3. Get each field using its ID.
//4. Set all alert text fields to "".
//4. Using the 'firstName' ID check if the feild is empty, if empty display a alert text in the HTML saying "You can not leave this field blank. Please enter your First Name." and stop execution.
//5  Using the 'lastnName' ID check if the feild is empty, if empty display a alert text in the HTML saying "You cannot leave the Family field blank. Please enter your family Name." and stop execution.
//6. Using the 'email' ID check if the email is at least 8 characters long and includes both '@' and '.' symbols, if not display a alert text in the HTML saying "Your email address must contain a '@' and a '.' and also be 8 characters or more long." and stop execution.
//7. Using the 'postcode' ID check if the postcode exactly 4 digits long, if not display a alert text in the HTML saying "Please enter your 4 digit postcode - Must be 4 digits." and stop execution.
//8. Using the 'cardNumber' ID check if the card number is exactly 16 digits long, if not display a alert text in the HTML saying "The card number must 16 numbers with no letters. Please re-enter." and stop execution
//9. Using the 'cvv' ID check if the CCV is exactly 3 digits long, if not display a alert text in the HTML saying "Please enter your 3 digit CCV from the back of your card, it must be 3 numbers." and stop execution
//10. Using the 'expiryMonth' and 'expiryYear' Check if the card has not expired by matching it to the current data, if the card is expired display a alert text in the HTML saying "The expiry date entered shows this card is expired, please enter a new expiry date." and stop execution.
//11. If all fields are correct return true and alert user the form was successfully submitted. 

function validateForm() {
    // get current month and year
    var date = new Date(); // Obtain the current Date
	var month = parseInt(date.getMonth()+1); // get the current month
    var year = parseInt(date.getFullYear()); // Get the current year

    // get all form fields
    var firstNameField = document.getElementById('firstName');
    var firstNameAlertText = document.getElementById('firstNameAlertText');

    var lastNameField = document.getElementById('lastName');
    var lastNameAlertText = document.getElementById('lastNameAlertText');

    var emailField = document.getElementById('email');
    var emailAlertText = document.getElementById('emailAlertText');

    var postcodeField = document.getElementById('postcode');
    var postcodeAlertText = document.getElementById('postcodeAlertText');

    var cardNumberField = document.getElementById('cardNumber');
    var creditCardAlertText = document.getElementById('creditCardAlertText');

    var ccvField = document.getElementById('ccv');
    var ccvAlertText = document.getElementById('ccvAlertText');

    var expiryMonthField = document.getElementById('expiryMonth');
    var expiryYearField = document.getElementById('expiryYear');
    var expiryDateAlertText = document.getElementById('expiryDateAlertText');

    var expiryMonth = parseInt(expiryMonthField.value);
    var expiryYear = parseInt(expiryYearField.value);

        // wipe all alertText fields before validation begins
        firstNameAlertText.innerHTML = "";
        lastNameAlertText.innerHTML = "";
        emailAlertText.innerHTML = "";
        postcodeAlertText.innerHTML = "";
        creditCardAlertText.innerHTML = "";
        ccvAlertText.innerHTML = "";
        expiryDateAlertText.innerHTML = "";
    

    // validate form fields
    if (firstNameField.value=="") {
        firstNameAlertText.innerHTML="You can not leave this field blank. Please enter your First Name.";
        firstNameField.focus();//set focus back to the textfield to be fixed
        return false;//don’t clear the form entries
    }

    if (lastNameField.value=="") {
        lastNameAlertText.innerHTML="You cannot leave the Family field blank. Please enter your family Name.";
        lastNameField.focus();//set focus back to the textfield to be fixed
        return false;//don’t clear the form entries
    }

    if (emailField.value.length <= 8 || !emailField.value.includes('@') || !emailField.value.includes('.')) {
        emailAlertText.innerHTML="Your email address must contain a '@' and a '.' and also be 8 characters or more long.";
        emailField.focus();
        return false;//don’t clear the form entries
    }

    if (postcodeField.value.length != 4 || isNaN(postcodeField.value)) {
        postcodeAlertText.innerHTML="Please enter your 4 digit postcode - Must be 4 digits.";
        postcodeField.focus();//set focus back to the textfield to be fixed
        return false;//don’t clear the form entries
    }

    if (cardNumberField.value.length != 16 || isNaN(cardNumberField.value)) {
        creditCardAlertText.innerHTML="The card number must 16 numbers with no letters. Please re-enter.";
        cardNumberField.focus();
        return false;//don’t clear the form entries
    }

    if (ccvField.value.length != 3 || isNaN(ccvField.value)) {
        ccvAlertText.innerHTML="Please enter your 3 digit CCV from the back of your card, it must be 3 numbers.";
        ccvField.focus();
        return false;//don’t clear the form entries
    }

    if (expiryYear < year || (expiryYear == year && expiryMonth < month)) {
        expiryDateAlertText.innerHTML="The expiry date entered shows this card is expired, please enter a new expiry date.";
        return false;//don’t clear the form entries
    }


    // if all validates pass alert user
    alert('Form submitted successfully!');
    return true;
}

//Pseudocode for Help button
// 1. Define Function
// 2. Set with and geight to 500px
// 3. When button is clicked open page

function openHelpPage() {
    // Open a new window with the help page
    window.open('./html/help.html', '_blank', 'width=500,height=500');
}

//Pseudocode for Go To Other Websites button
// 1. Define function
// 2. Declare the three website choises
// 3. Prompt user with those three choises but inputing 1, 2 or 3.
// 3.1. Validate user's choice
// 4. open the chosen website in a new 800x800 window


function openWebsite() {
    // array of website choices
    const websites = [
        "https://www.google.com",
        "https://www.tafesa.edu.au/mytafe-sa",
        "https://learn.tafesa.edu.au"
    ];

    let choice = "";

    // validate user's choice
    while (choice !== '1' && choice !== '2' && choice !== '3') {
        choice = prompt("Please enter a number for the website you want to visit:\n\n" +
            "Website 1: https://www.google.com\n" +
            "Website 2: https://www.tafesa.edu.au/mytafe-sa\n" +
            "Website 3: https://learn.tafesa.edu.au");
    }

    // open the chosen website in a new 800x800 window
    window.open(websites[choice - 1], "_blank", "width=800,height=800");
}

//When this field is selected this changes the input box Yellow
function changeBgd(textField){
	textField.style.background="gold";
    
}

//When the field is no longer selected this changes the input box back to white
function resetBgd(textField){
	textField.style.background="white";
    
}