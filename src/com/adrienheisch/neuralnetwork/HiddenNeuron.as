package com.adrienheisch.neuralnetwork 
{
	
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class HiddenNeuron extends NotInputNeuron 
	{
		
		public function HiddenNeuron() 
		{
			super();
		}
		
		override protected function inputFormula(pIndex:int):Number 
		{
			return inputLayer[pIndex].output * weigths[pIndex];
		}
		
		override protected function setOutput(pInput:Number):void 
		{
			output = pInput;
		}

	}
	
}