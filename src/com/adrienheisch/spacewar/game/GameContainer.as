package com.adrienheisch.spacewar.game 
{
	
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class GameContainer extends MovieClip 
	{

		/**
		 * instance unique de la classe GameContainer
		 */
		protected static var _instance: GameContainer;
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function get instance (): GameContainer {
			if (_instance == null) _instance = new GameContainer();
			return _instance;
		}
	
		public function GameContainer() 
		{
			super();
			
			if (_instance != null) throw new Error(this + "is a Singleton, please use GameContainer.instance");
			else {
				_instance = this;
				
			}
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		public function destroy (): void {
			_instance = null;
			if (parent != null) parent.removeChild(this);
		}

	}
	
}