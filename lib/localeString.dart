import 'package:get/get.dart';

class LocalString extends Translations {
  @override

  Map<String, Map<String, String>> get keys => {
        'en_US': {
          //choose language page
          'pleaseSelectYourLanguage':'please select your language',
          'chooseYourPerferredLanguage':'Choose Your Perferred Language',
          'tamil':'தமிழ்',



          //login page
          'farmers':'Farmers',
          'login': 'LOGIN',
          'mobile': 'Mobile Number',
          'itsNiceToSeeYouAgain':"It's nice to see you again!",
          'loginToContinueToYourAccount':'Login to continue to your account.',
          'getOTP':'Get OTP',
          'pleaseEnterTheMobileNumber':'Please enter the Mobile Number',
          'pleaseEnterValidMobileNumber':'Please enter valid Mobile Number',
          'mobileNumberisnotRegistered':'Mobile Number is not Registered',
          'oTPSentSuccessfully':'OTP Sent Successfully',


          //otp screen
          'otp':'OTP',
          'a6-digitOTPCodeWasSuccessfullySentToYourEmail&MobileNumber':'A 6-digit OTP code was successfully sent to your Email & Mobile Number',
          "didn'tReceiveOTP":"Didn't receive OTP ?",
          'resendOTP':'Resend OTP',
          'submit':'Submit',
          'pleaseEnterThe6-digitOTP':'Please enter the 6-digit OTP',
          'oTPValidatedSuccessfully':'OTP validated Successfully',
          'pleaseEnterValidOTP':'Please enter valid OTP',


          //dashboard
          'logOut':'Log Out',
          'approvedInvoices':'Approved Invoices',
          'paidInvoices':'Paid Invoices',
          'currentlyThereIsNoPendingInvoices':'Currently there is no pending Invoices',
          'currentlyThereIsNoPaidInvoices':'Currently there is no paid Invoices',
          'hi':'Hi',


          //invoice screens
          'from':'FROM',
          'amount':'AMOUNT',
          'DATE':'DATE',
          'DUEDATE':'DUE DATE',
          'requestEarlyPaymentSubmittedSuccesfully':'Request early payment submitted succesfully',
          'requestEarlyPayment':'Request early Payment',
          'cancel':'Cancel',
          'ok':'Ok',



          //invoice details
          'invoiceDetails':'Invoice Details',
          'buyerName':'Buyer Name',
          'invoiceNumber':'Invoice Number',
          'invoiceAmount':'Invoice Amount',
          'status':'Status',
          'date':' Payment Date',
          'dueDate':'Due Date',
          'interestAmount':'Interest Amount',
          'financeAmount':'Finance Amount',
          'interestRate':'Interest Rate',


          //user profile
          'userProfile':'User Profile',
          'name':'Name',
          'country':'Country',
          'state':'State',
          'city':'City',
          'pINCode':'PIN Code',
          'address':'Address',
          'pANCard':'PAN Card',
          'aadharCard':'Aadhar Card',
          'update':'Update',
          'cancel':'Cancel',
          'chooseLanguage':'Choose Language',

        },


        'ta': {

          //user profile
          'userProfile':'பயனர் சுயவிவரம்',
          'name':'பெயர்',
          'country':'நாடு',
          'state':'மாநிலம்',
          'city':'நகரம்',
          'pINCode':' அஞ்சல் குறியீட்டு எண்',
          'address':'முகவரி',
          'panCard':' PAN எண்',
          'aadharCard':'ஆதார் எண் ',
          'update':'புதுப்பிக்க',
          'cancel':'இரத்து செய்யவும்',
          'chooseLanguage':'மொழியைத் தேர்ந்தெடுக்கவும்',

          //choose language
          'pleaseSelectYourLanguage':'தயவுசெய்து உங்கள் மொழியைத் தேர்ந்தெடுக்கவும்.',
          'chooseYourPerferredLanguage':'உங்களுக்கு விருப்பமான மொழியைத் தேர்வு செய்யவும்',
          'tamil':'தமிழ்',


          //login
          'farmers':'விவசாயிகள்',
          'login': 'உள்நுழைய',
          'mobile': 'அலைபேசி எண்',
          'itsNiceToSeeYouAgain':'உங்களை மீண்டும் சந்திப்பதில் மகிழ்ச்சி!',
          'loginToContinueToYourAccount':'உங்கள் கணக்கில் தொடர உள்நுழைக.',
          'getOTP':'OTP பெறவும்',
          'pleaseEnterTheMobileNumber':'தயவுசெய்து அலைபேசி எண்ணை உள்ளீடவும் ',
          'pleaseEnterValidMobileNumber':'தயவுசெய்து சரியான அலைபேசி எண்ணை உள்ளீடவும் ',
          'mobileNumberisnotRegistered':'இந்த அலைபேசி எண் பதிவு செய்யப்படவில்லை ',
          'oTPSentSuccessfully':' OTP வெற்றிகரமாக அனுப்பப்பட்டுள்ளது ',

          //otp screen
          'otp':'OTP',
          'a6-digitOTPCodeWasSuccessfullySentToYourEmail&MobileNumber':'தங்கள் அலைபேசிக்கு ஒரு 6-இலக்க குறியீடு அனுப்பப்பட்டுள்ளது. அதை இங்கே உள்ளீடவும்',
          "didn'tReceiveOTP":"OTP பெறவில்லையா?",
          'resendOTP':'மீண்டும் OTP பெறவும்',
          'submit':'சமர்ப்பிக்க',
          'pleaseEnterThe6-digitOTP':'தயவுசெய்து 6-இலக்க OTP-யை உள்ளீடவும் ',
          'oTPValidatedSuccessfully':'OTP வெற்றிகரமாக சரிபார்க்கப்பட்டது',
          'pleaseEnterValidOTP':'தயவுசெய்து சரியான OTP - யை உள்ளீடவும் ',


          //dashboard
          'logOut':'வெளியேறு',
          'approvedInvoices':'அங்கீகரிக்கப்பட்ட இரசீதுகள்',
          'paidInvoices':'பணம் செலுத்தப்பட்ட இரசீதுகள்',
          'currentlyThereIsNoPendingInvoices':'தற்சமயம் எந்த இரசீதுகளும் நிலுவையில் இல்லை ',
          'currentlyThereIsNoPaidInvoices':'தற்சமயம் எந்த இரசீதும் கட்டணம் செலுத்தப்படவில்லை',
          'hi':'வணக்கம்',

          //invoice details
          'invoiceDetails':'இரசீது - விவரம்',
          'buyerName':'நுகர்வோர் பெயர்',
          'invoiceNumber':'இரசீது எண்',
          'invoiceAmount':'இரசீதுக்கான தொகை',
          'status':'இரசீதின் தற்போதைய நிலை',
          'date':'தேதி',
          'dueDate':'பணம் செலுத்த கடைசிதேதி',
          'financeAmount':'நிதித் தொகை',
          'interestRate':'வட்டி விகிதம்',

          //invoice screens
          'from':'அனுப்புநர்',
          'amount':'தொகை',
          'requestEarlyPaymentSubmittedSuccesfully':'இந்த இரசீதுக்கான நிதி கோரிக்கை வெற்றிகரமாக அனுப்பப்பட்டது ',
          'requestEarlyPayment':'நிதி பெறுக',
          'DATE':'இரசீது தேதி',
          'DUEDATE':'பணம் செலுத்த கடைசி தேதி',
          'interestAmount':'வட்டி தொகை',
          'cancel':'ரத்து செய்',
          'ok':'சரி',
        }
      };
}
