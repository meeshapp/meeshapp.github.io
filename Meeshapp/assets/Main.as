package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;

	public class Main extends MovieClip {

		var startMessage: String;
		var mysteryNumber: uint; //unit = unsigned integer which is a positive number
		var currentGuess: uint;
		var guessesRemaning: uint;
		var guessesMade: uint;
		var gameStatus: String;
		var gameWon: Boolean;
		var cheat:uint;
		//initialize the constructor
		public function Main() {
			// constructor code
			init();
		}

		function init(): void {
			//initialize the variables
			startMessage = 'I am thinking of a number between 1 and 100. \n Guess the right number and win a promo code for \n 10% off any service!';
			mysteryNumber = Math.ceil(Math.random() * 100);
			guessesRemaning = 10;
			guessesMade = 0;
			gameStatus = "";
			gameWon = false;
			cheat = 101;
			trace(mysteryNumber);

			//initialize the text fields
			output.text = startMessage;
			input.text = "";
			input.backgroundColor = 0x80dfff;
			input.restrict = "0-9";
			stage.focus = input;
			input.addEventListener(KeyboardEvent.KEY_DOWN, onEnter);
			
			//initialize the buttons
			guessBtn.enabled = true;
			guessBtn.alpha = 1;
			playAgainBtn.visible = false;
						
			//add event listener to the button
			guessBtn.addEventListener(MouseEvent.CLICK, TookAGuess);
		}
		
		function onEnter(event:KeyboardEvent){
			if (event.charCode == 13){
				onGuessButtonClick();
			}
		}
		
		function TookAGuess(event:MouseEvent):void{
			onGuessButtonClick();
		}

		function onGuessButtonClick () {			
			guessesRemaning --; //decreases # of guesses remaning by 1
			guessesMade ++; //increases # of guesses made by 1
			gameStatus = "Guesses Remaning:" + guessesRemaning + ", Guesses Made:" + guessesMade;
			// assign input from text field to the current variable
			currentGuess = uint(input.text);
			//if statement to process input
			if (currentGuess == cheat) {
				output.text = "Cheat code Activated" + "\n" + "The number is " + mysteryNumber;
			}
			else if (currentGuess > mysteryNumber) {
				output.text = "That's too high." + "\n" + gameStatus;
				checkGameOver();				
			}
			else if (currentGuess < mysteryNumber){
				output.text = "That's too low." + "\n" + gameStatus;
				checkGameOver();
			}
			else {
				gameWon = true;
				endGame();
			}
		}
		
		function checkGameOver():void {
			if (guessesRemaning < 1) {
				endGame();
			}
		}
		function endGame():void {
			if(gameWon){
				output.text = "Yes, it's " + mysteryNumber + "!" + "\n" + "Here is your Promo code: XDFH" + mysteryNumber;
			}
			else {
				output.text = "Oh no you're out of guesses! Please try again.";
			}
			
			//Disable the Guess Button
			guessBtn.removeEventListener(MouseEvent.CLICK, TookAGuess);
			input.removeEventListener(KeyboardEvent.KEY_DOWN, onEnter);
			guessBtn.enabled = false;
			guessBtn.alpha = 0.5;
			playAgainBtn.visible = true;
			playAgainBtn.addEventListener(MouseEvent.CLICK, onPlayAgainButtonClick);
			
		}
		
		function onPlayAgainButtonClick(event:MouseEvent):void{
			init();
			playAgainBtn.removeEventListener(MouseEvent.CLICK, onPlayAgainButtonClick);
		}		
	}
}