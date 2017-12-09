package com.adrienheisch.neuralnetwork 
{
	import com.adrienheisch.spacewar.Main;
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class NeuralNetwork 
	{
		public static var layers_lengths: Vector.<uint> = new <uint> [6, 2]; //output <-- hidden layers <-- input
		
		public var stage: Stage;
		public var graphic: GraphicRepresentation;
		public var layers: Vector.<Vector.<Neuron>> = new Vector.<Vector.<Neuron>>(layers_lengths.length, true);
		public var input: Vector.<InputNeuron> = new Vector.<InputNeuron>(layers_lengths[layers_lengths.length - 1], true);
		public var output: Vector.<OutputNeuron> = new Vector.<OutputNeuron>(layers_lengths[0], true);
		public var chromosome: Vector.<Number>;
		public var fitness: Number = 0;
		
		public function NeuralNetwork() 
		{
			chromosome = new <Number>[0.7362667419947684, 0.02174665266647935, 0.555042983032763, 1.8706661686301231, 0.33663386618718505, 0.9154597306624055, 0.04369535343721509, 0.07794454507529736, 1.1621928280219436, 0.9859128352254629, 0.5709115797653794, 1.458938899450004];//Genetic.chromosomes[Genetic.index][1];
			
			stage = Main.instance.stage;
			stage.addChild(graphic = new GraphicRepresentation());
			
			var lLayer: Vector.<Neuron>;
			var lNeuron:Neuron;
			for (var i: int = layers.length - 1; i >= 0; i--) {
				lLayer = new Vector.<Neuron>(layers_lengths[i], true);
				layers[i] = lLayer;
				for (var j: int = lLayer.length - 1; j >= 0; j--) {
					if (i == layers.length - 1) {
						graphic.addChild(lNeuron = new InputNeuron());
					}
					else {
						graphic.addChild(lNeuron = (i == 0 ? new OutputNeuron() : new HiddenNeuron()));
						NotInputNeuron(lNeuron).inputLayer = layers[i + 1];
						for (var k: int = 0; k < 2; k++) {
							NotInputNeuron(lNeuron).weigths[k] = chromosome[j+k];
						}
					}
					lLayer[j] = lNeuron;
					lNeuron.network = this;
					lNeuron.x = (j + 1) * stage.stageWidth / (lLayer.length + 1);
					lNeuron.y = (i + 1) * stage.stageHeight / (layers.length + 1);
				}
			}
			
			lLayer = layers[layers.length - 1];
			for (i = lLayer.length - 1; i >= 0; i--) {
				input[i] = InputNeuron(lLayer[i]);
			}
			/*
			for (i = Neuron.list.length - 1; i >= 0; i--) {
				lNeuron = Neuron.list[i];
				if (lNeuron is NotInputNeuron) {
					for (j = lLayer.length - 1; i >= 0; i--) {
						
					chromosome[i] = NotInputNeuron(lNeuron).weigths[j];
					}
				}
			}
			*/
			lLayer = layers[0];
			for (i = lLayer.length - 1; i >= 0; i--) {
				output[i] = OutputNeuron(lLayer[i]);
			}
			
			graphic.scaleX = 0.2;
			graphic.scaleY = 0.2;
			
			stage.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		public function loop(pEvent: Event): void {
			var lGenericNeuron: Neuron;
			for (var i: int = Neuron.list.length - 1; i >= 0; i--) {
				lGenericNeuron = Neuron.list[i];
				if (lGenericNeuron is NotInputNeuron) NotInputNeuron(lGenericNeuron).refresh();
				if (lGenericNeuron is InputNeuron) InputNeuron(lGenericNeuron).refresh();
			}
		}
		
		public function destroy(): void {
			trace(/*Genetic.index, */uint(fitness) + "   " + chromosome);
			for (var i: int = Neuron.list.length - 1; i >= 0; i--) {
				Neuron.list[i].destroy();
			}
			//Genetic.chromosomes[Genetic.index][0] = fitness;
		}
		
	}

}