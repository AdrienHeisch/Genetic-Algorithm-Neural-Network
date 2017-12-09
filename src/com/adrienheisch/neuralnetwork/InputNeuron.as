package com.adrienheisch.neuralnetwork 
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class InputNeuron extends Neuron 
	{
		
		public function InputNeuron() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(pEvent: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

	}
	
}