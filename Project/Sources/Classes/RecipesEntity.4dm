Class extends Entity

exposed Function generatePDF() : Blob
	
	var $pdfBlob : Blob
	var $wpDoc : Object
	var $cookingTimePrn_t : Text
	var $ingredientsPrn_t : Text
	var $cookingStepsPrn_t : Text
	var $item_t : Text
	var $hour_l : Integer
	var $min_l : Integer
	var $i : Integer
	var $lowerCase_b : Boolean
	var $range : Object
	var $steps : Collection
	var $ingredient : cs.IngredientsEntity
	var $ingredients : cs.IngredientsSelection
	
	// ----------------------------------------
	// 1. Calcul du temps de cuisson
	// ----------------------------------------
	$cookingTimePrn_t := ""
	$hour_l := Hour(This.CookTime)
	$min_l := Minute(This.CookTime)
	
	If ($hour_l > 0)
		$cookingTimePrn_t := String($hour_l)+" Hr"
	End if
	If ($min_l > 0)
		If ($cookingTimePrn_t # "")
			$cookingTimePrn_t := $cookingTimePrn_t+" "
		End if
		$cookingTimePrn_t := $cookingTimePrn_t+String($min_l)+" Min"
	End if
	
	// ----------------------------------------
	// 2. Construction de la liste d'ingrédients
	// ----------------------------------------
	$ingredientsPrn_t := ""
	$ingredients := This.ingredients.orderBy("ID asc")
	
	For each ($ingredient; $ingredients)
		
		$lowerCase_b := False
		
		If ($ingredient.Quantity > 0)
			$ingredientsPrn_t := $ingredientsPrn_t+String($ingredient.Quantity)+" "
			$lowerCase_b := True
		End if
		
		If ($ingredient.Unit # "")
			$ingredientsPrn_t := $ingredientsPrn_t+$ingredient.Unit+" "
		End if
		
		If ($ingredient.Item # "")
			If ($lowerCase_b)
				$ingredientsPrn_t := $ingredientsPrn_t+Lowercase($ingredient.Item)
			Else
				$item_t := Lowercase($ingredient.Item)
				$item_t[[1]] := Uppercase($item_t[[1]])
				$ingredientsPrn_t := $ingredientsPrn_t+$item_t
			End if
		End if
		
		If ($ingredient.Description # "")
			$ingredientsPrn_t := $ingredientsPrn_t+", "+Lowercase($ingredient.Description)
		End if
		
		$ingredientsPrn_t := $ingredientsPrn_t+".\r"
		
	End for each
	
	// ----------------------------------------
	// 3. Construction des étapes
	// ----------------------------------------
	$cookingStepsPrn_t := ""
	$steps := This.CookingSteps.steps
	
	If ($steps # Null)
		For ($i; 0; $steps.length-1)
			$cookingStepsPrn_t := $cookingStepsPrn_t+String($i+1)+". "+$steps[$i]
			If ($i < $steps.length-1)
				$cookingStepsPrn_t := $cookingStepsPrn_t+"\r\r"
			End if
		End for
	End if
	
	// ----------------------------------------
	// 4. Création du document Write Pro
	// ----------------------------------------
	$wpDoc := WP New
	
	// -- Titre --
	$range := WP Text range($wpDoc; wk start text; wk end text)
	WP SET TEXT($range; This.Name; wk replace)
	WP SET ATTRIBUTES($range; wk font size; 22)
	WP SET ATTRIBUTES($range; wk font bold; True)
	WP SET ATTRIBUTES($range; wk text align; wk center)
	
	// -- Temps de cuisson --
	$range := WP Text range($wpDoc; wk end text; wk end text)
	WP SET TEXT($range; "\rTemps de cuisson : "+$cookingTimePrn_t+"\r\r"; wk append)
	WP SET ATTRIBUTES($range; wk font size; 11)
	WP SET ATTRIBUTES($range; wk font bold; False)
	WP SET ATTRIBUTES($range; wk text color; "#888888")
	WP SET ATTRIBUTES($range; wk text align; wk center)
	
	// -- Titre Ingrédients --
	$range := WP Text range($wpDoc; wk end text; wk end text)
	WP SET TEXT($range; "Ingrédients\r"; wk append)
	WP SET ATTRIBUTES($range; wk font size; 15)
	WP SET ATTRIBUTES($range; wk font bold; True)
	WP SET ATTRIBUTES($range; wk text color; "#000000")
	WP SET ATTRIBUTES($range; wk text align; wk left)
	
	// -- Liste ingrédients --
	$range := WP Text range($wpDoc; wk end text; wk end text)
	WP SET TEXT($range; $ingredientsPrn_t+"\r"; wk append)
	WP SET ATTRIBUTES($range; wk font size; 11)
	WP SET ATTRIBUTES($range; wk font bold; False)
	
	// -- Titre Instructions --
	$range := WP Text range($wpDoc; wk end text; wk end text)
	WP SET TEXT($range; "Instructions\r"; wk append)
	WP SET ATTRIBUTES($range; wk font size; 15)
	WP SET ATTRIBUTES($range; wk font bold; True)
	
	// -- Étapes --
	$range := WP Text range($wpDoc; wk end text; wk end text)
	WP SET TEXT($range; $cookingStepsPrn_t; wk append)
	WP SET ATTRIBUTES($range; wk font size; 11)
	WP SET ATTRIBUTES($range; wk font bold; False)
	
	// ----------------------------------------
	// 5. Export en PDF
	// ----------------------------------------
	WP EXPORT DOCUMENT($wpDoc; $pdfBlob; wk pdf)
	
	return $pdfBlob