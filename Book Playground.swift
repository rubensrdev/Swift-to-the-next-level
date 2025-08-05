
import Foundation

//1.  if case let es una forma elegante de filtrar y desempaquetar valores asociados de un enum sin necesidad de un switch completo.
enum Activity {
	case programming(String)
	case walking(Int)
	case talking(String)
	case sleeping
}

let currentActivity = Activity.programming("Swift")

if case let .programming(language) = currentActivity {
	print("I'm programming in \(language)")
}

// @unknown default es una forma inteligente de anticiparte a futuros casos de un enum, asegurando que tu código siga funcionando y que recibas una advertencia para revisarlo cuando sea necesario.
// 	✅ Es una práctica recomendada especialmente con enums de librerías externas o APIs que pueden evolucionar.
func displayName(for component: Calendar.Component) -> String {
	switch component {
		case .year:
			"Year"
		case .month:
			"Month"
		case .day:
			"Day"
			// manejo explícito de casos conocidos
		@unknown default:
			// casos desconocidos
			"Unknown Component"
	}
}

displayName(for: .era)

//Los rangos unilaterales en Swift (..< y ...) permiten categorizar valores continuos sin necesidad de límites exactos, haciendo que el switch sea más expresivo y menos propenso a errores.
let temperature = 31

switch temperature {
	case ..<0:
		print("It's freezing! Wear a heavy coat.")
	case 0..<15:
		print("It's cool. Wear a jacket.")
	case 15..<25:
		print("Mild weather. A sweater should be fine.")
	case 25...:
		print("It's hot! T-shirt weather.")
	default:
		print("Temperature out of range.")
}

// ~= es el operador que Swift usa para decidir si un valor coincide con un patrón en switch. Puedes sobrecargarlo para permitir comparaciones personalizadas entre tipos distintos.
// 💡 Recuerda: patrón = lado izquierdo, valor = lado derecho. Usa esta técnica cuando quieras que un switch trabaje con lógica más rica que una simple igualdad.
struct Circle {
	var radius: Double
}

func ~= (pattern: Double, value: Circle) -> Bool {
	value.radius == pattern
}

let myCircle = Circle(radius: 5.0)

switch myCircle {
	case 5:    print("Circle with a radius of 5")
	case 10:   print("Circle with a radius of 10")
	default:   print("Circle with a different radius")
}

// Swift permite usar tuplas en switch para evaluar varias variables a la vez.
// Cada case puede usar rangos, literales, patrones e incluso where para lógica extra.
// Esto reemplaza if anidados => código más limpio y legible
//💡 Recuerda: Usa tuplas en switch siempre que quieras evaluar combinaciones de estados o condiciones de manera declarativa y sin repeticiones.

let energy = 63
let timeOfDay = "evening"

switch (energy, timeOfDay) {
	case (80...100, "morning"):
		print("You're full of energy! Great time for a workout.")
	case (50...79, "morning"):
		print("You're doing okay. Maybe a light jog?")
	case (0...49, "morning"):
		print("Take it easy, maybe stretch a little.")
	case (80...100, "evening"):
		print("You're full of energy! Perfect for some evening training.")
	case (50...79, "evening"):
		print("You have some energy left. How about some yoga?")
	case (0...49, "evening"):
		print("Not much energy left. Time to rest.")
	default:
		print("Check your energy level and time of day, something's off.")
}

// Switch con múltiples valores opcionales simultáneamente.
// Puedes hacer switch sobre una tupla de opcionales para evaluar todas las combinaciones posibles.
// Los patrones value? desenvuelven automáticamente los valores, mientras que nil hace match solo con valores nulos.
// Esta técnica reemplaza if let anidados => código más legible, declarativo y fácil de mantener.
// 💡 Recuerda: cuando tengas varios Optional y múltiples combinaciones posibles, usa un switch con tuplas para un código limpio y elegante.

var optionalInt1: Int? = 1
var optionalInt2: Int? = nil

switch (optionalInt1, optionalInt2) {
	case let (value1?, value2?):
		print("Both values are present: \(value1) and \(value2)")
	case let (value1?, nil):
		print("First value is present: \(value1)")
	case let (nil, value2?):
		print("Second value is present: \(value2)")
	case (nil, nil):
		print("Both are nil")
}

