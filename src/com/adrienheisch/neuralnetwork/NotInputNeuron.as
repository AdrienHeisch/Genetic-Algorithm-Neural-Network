package com.adrienheisch.neuralnetwork
{
	
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class NotInputNeuron extends Neuron
	{
		//Don't directly use this class !
		
		public var inputLayer:Vector.<Neuron>;
		public var weigths: Vector.<Number> = new Vector.<Number>(NeuralNetwork.layers_lengths[NeuralNetwork.layers_lengths.length - 1], true);
		public var threshhold:Number = 0.5;
		
		public function NotInputNeuron()
		{
			super();
		}
		
		override public function refresh():void
		{
			var lInput:Number = 0;
			for (var i:int = inputLayer.length - 1; i >= 0; i--)
			{
				lInput += inputFormula(i);
			}
			setOutput(lInput);
			super.refresh();
		}
		
		protected function inputFormula(pIndex:int):Number
		{
			return 0;
		}
		
		protected function setOutput(pInput:Number):void
		{
			return;
		}
	
	}

}