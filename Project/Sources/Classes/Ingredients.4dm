Class extends DataClass

	
exposed Function SaveIngredient($currentIng : cs.IngredientsEntity; $currentRecipe : cs.RecipesEntity) : cs.IngredientsSelection
    var $existing_e : cs.IngredientsEntity
    var $newIngredient_e : cs.IngredientsEntity

    // Vérifier uniquement parmi les ingrédients de la recette courante
	If ($currentIng.ID # 0) && ($currentIng.ID # Null)
        $existing_e := ds.Ingredients.get($currentIng.ID)
    End if

    If ($existing_e = Null)
        // Création
        $newIngredient_e := ds.Ingredients.new()
        $newIngredient_e.RecipesID := $currentRecipe.ID
        $newIngredient_e.Item := $currentIng.Item
        $newIngredient_e.Quantity := $currentIng.Quantity
        $newIngredient_e.Unit := $currentIng.Unit
        $newIngredient_e.Description := $currentIng.Description
        $newIngredient_e.save()
    Else
        // Modification
		$existing_e.Item := $currentIng.Item
        $existing_e.Quantity := $currentIng.Quantity
        $existing_e.Unit := $currentIng.Unit
        $existing_e.Description := $currentIng.Description
        $existing_e.save()
    End if

    return ds.Ingredients.query("RecipesID = :1"; $currentRecipe.ID)

exposed Function dropIngredient($ing: cs.IngredientsEntity; $ings: cs.IngredientsSelection) : cs.IngredientsSelection
	var $result : cs.IngredientsSelection
	return $result

exposed Function SaveSelectedIngs($ings : Collection): Collection
	var $o : object
	var $result : Collection
	$result := New collection()

	For each ($o; $ings)
        If ($o.selected=true)
            $result.push($o)
        End if
    End for each
	return $result

exposed Function SearchIngredients($ings : Collection; $searchText: Text) : Collection
	var $o : object
	var $selectedIngs : Collection
	var $final : Collection
	var $ingredients : Collection
    var $result : Collection

	$result := New Collection()
	$selectedIngs := ds.Ingredients.SaveSelectedIngs($ings)
	$final := ds.Ingredients.getIngredientsWithSelected()
        For each ($o; $final)
			For each ($e; $selectedIngs)
				If (($o.content.Item = $e.content.Item) & ($e.selected = True))
					$o.selected := True
				End if
				
		    End for each
			
		End for each
	If ($searchText = "")
		return $final
    End if

    For each ($o; $ings)
        If (Position($searchText; $o.content.Item; *) > 0 | $o.selected = True)
            $result.push($o)
        End if
    End for each
    
	return $result


exposed Function getIngredientsWithSelected() : Collection
    var $ings : cs.IngredientsSelection
    var $final : Collection
    var $o : Object
	var $item : object

    $final := New collection()
    $ings := ds.Ingredients.all()
	
    For each ($item; $ings)
        $o := New object()
        $o.content := $item.toObject()  
        $o.selected := False
        $final.push($o)
    End for each
    
    return $final

exposed Function updateSelected($allIngredients : Collection; $current : Object) : Collection
    var $item : Object
    
    For each ($item; $allIngredients)
        If ($item.content.ID = $current.content.ID)
            $item.selected := Not($item.selected)
        End if
    End for each
    
    return $allIngredients