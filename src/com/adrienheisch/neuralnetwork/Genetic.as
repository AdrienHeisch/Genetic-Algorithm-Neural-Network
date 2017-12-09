package com.adrienheisch.neuralnetwork
{
	import com.adrienheisch.spacewar.game.GameManager;
	import com.adrienheisch.spacewar.utils.Utils;
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class Genetic
	{
		public static const POPULATION_SIZE: uint = 20;
		public static const ELITISM_SIZE: uint = 5;
		public static const RANDOM_SIZE: uint = 3;
		public static const NORMAL_SIZE: uint = POPULATION_SIZE - ELITISM_SIZE - RANDOM_SIZE;
		public static const MUTATION_RATE: Number = 0.01;
		
		public static var generationCounter: int = 0;
		
		public static var index: int;
		public static var winners: int;
		public static var previousAverage: Number = 0;
		
		public static var chromosomes: Array = [];
		
		public static function init():void
		{
			for (var i: int = POPULATION_SIZE - 1; i >= 0; i--) {
				if (chromosomes[i] == null) chromosomes[i] = [null, randomChromosome()];
			}
			index = -1;
			trace("Generation " + generationCounter++ + " :");
			nextChromosome();
		}
		
		public static function nextChromosome(): void {
			GameManager.destroyAllInstances();
			if (index >= POPULATION_SIZE - 1) {
				chromosomes.sort(Utils.sortArrayAtIndex0);
				var eliteChromosomes: Vector.<Vector.<Number>> = new Vector.<Vector.<Number>>(ELITISM_SIZE, true);
				var newChromosomes: Vector.<Vector.<Number>> = new Vector.<Vector.<Number>>(NORMAL_SIZE, true);
				var maxFitness: Number = chromosomes[chromosomes.length - 1][0];
				var sumFitness:Number = 0;
				for (var i: int = 0; i < chromosomes.length; i++) sumFitness += chromosomes[i][0];
				var averageFitness: Number = sumFitness / chromosomes.length;
				trace("\nAverage fitness : " + averageFitness + ", improvement : " + (100 * (averageFitness - previousAverage) / previousAverage) + "%, " + (100 * winners / POPULATION_SIZE) + "% winners.");
				trace("\n============================================================================================================\nGeneration " + generationCounter++);
				previousAverage = averageFitness;
				var rouletteWheel: Number;
				var lParentA: Vector.<Number> = new Vector.<Number>(12, true);
				var lParentAWeigth: Number;
				var parentAIndex: int;
				var lParentB: Vector.<Number> = new Vector.<Number>(12, true);
				var lChild: Vector.<Number> = new Vector.<Number>(12, true);
				for (i = newChromosomes.length - 1; i >= 0; i--) {
					for (var j:int = 1; j >= 0; j--) {
						rouletteWheel = Math.random() * maxFitness;
						for (var k:int = 0; k < chromosomes.length; k++) {
							if (rouletteWheel <= chromosomes[k][0]) {
								if (j == 1) {
									lParentA = chromosomes[k][1];
									parentAIndex = k;
								}
								else lParentB = chromosomes[k][1];
								break;
							}
						}
					}
					lChild = Utils.clone(lParentA);
					lParentAWeigth = chromosomes[parentAIndex][0] / (chromosomes[parentAIndex][0] + chromosomes[k][0]);
					for (j = lParentA.length - 1; j >= 0; j--) {
						if (Math.random() < MUTATION_RATE) lChild[j] += Math.random();
						else if (Math.random() > lParentAWeigth) lChild[j] = lParentB[j];
					}
					newChromosomes[i] = lChild;
				}
				for (i = 0; i < ELITISM_SIZE; i++) eliteChromosomes[i] = chromosomes[chromosomes.length - 1 - i][1];
				for (i = 0; i < eliteChromosomes.length; i++) chromosomes[i][1] = eliteChromosomes[i];
				for (i = 0; i < newChromosomes.length; i++) chromosomes[i + eliteChromosomes.length][1] = newChromosomes[i];
				for (i = 0; i < RANDOM_SIZE; i++) chromosomes[i + eliteChromosomes.length + newChromosomes.length][1] = randomChromosome();
				index = 0;
				winners = 0;
			} else index++;
			GameManager.startGame();
		}
		
		public static function randomChromosome(): Vector.<Number>
		{
			var chromosome: Vector.<Number> = new Vector.<Number>(12, true);
			var genomeLength: uint;
			for (var i: int = NeuralNetwork.layers_lengths.length - 2; i >= 0; i--) {
				genomeLength += NeuralNetwork.layers_lengths[i] * 2;
			}
			for (i = genomeLength - 1; i >= 0; i--) {
				chromosome[i] = Math.random();
			}
			return chromosome;
		}
		
	}
}