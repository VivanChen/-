# YesNoDialog
A dynamic jQuery yes no dialog

## Bower install
1. ```` bower install git@github.com:stein189/YesNoDialog.git ````
2. Include file ```` bower_components/YesNoDialog/js/questionDialog.js ````
3. Include file ```` bower_components/YesNoDialog/css/dialogStyle.css ````
4. Make sure u have jquery included in your website

## Manual install
To use the dialog please follow the instructions below.

1. Make sure u have jquery included in your website
2. Move questionDialog.js to your javascript folder and include it in the page where you want to use the dialog.
3. Copy and paste the css to your own css file

## Usage

> <b>showQuestionDialog()</b> is deprecated since version 1.3 and will be removed in version 2, use <b>$.showQuestionDialog()</b> instead.

```js
$.showQuestionDialog('header text', 'message text', options, function(response){
  // Your code here...
  // For example to check if the ok button is pressed you could do
  if (response === 'ok') {
    // Ok button is pressed
  }
});
````
Options:
```js
// The var options is a object with data for the buttons in the dialog
// If the attribute `overlay` is not present then the user is forced to choose one of the options.

var options = {
  overlay: 'Response when overlay was clicked here',
  buttons: {
    firstButtonText:  firstButtonClass,
    secondButtonText: secondButtonClass,
    thirdButtonText:  thirdButtonClass
  }
};

// The next button classes are avalible
// alert 				color red
// save 		 		color green

// After the user clicked a button the callback function will be executed.
// The response of the callback function will be the text of the clicked button.
````

Example usage
```js
/**
 * For example we use 2 buttons (yes & no) and we will delete an item
 *
 * When the user clicks yes the response will be a string with value 'yes'
 * When the user clicks no the resposne will be a string with value 'no'
 *
 * In the option object we will fill the overlay value with 'no', because when a user clicks outside of the dialog we do not want to delete the item.
 * If you want to force the user to choose one of the given options you can delete the `overlay` attribute
 */

var options = {
  overlay: 'no',
  buttons: {
    'yes':  'alert',
    'no': 'save'
  }
};

$.showQuestionDialog('Delete item', 'Are you sure you want to delete this item?', options, function(response) {
  /**
   * Check if the response is yes
   */
  if (response === 'yes') {
    /** 
     * Here we should delete the item
     */
  }
});
````

Thats it, enjoy the dialog and happy coding! :)

![Alt text](http://cotex.nl/Images/example.png "Screenshot")
