Class extends DataClass

exposed Function SearchIngredients($ings : Collection; $searchText: Text) : Collection
	var $result : Collection
	
	If ($searchText = "")
        $result := ds.Ingredients.getIngredientsWithSelected()
		return $result
    End if

    $result := New collection()
    
    For each ($o; $ings)
        If (Position($searchText; $o.content.Item; *) > 0)
            $result.push($o)
        End if
    End for each
    
	return $result

exposed Function saveCurrentRecipeIngredient( $ingredients : cs.IngredientsSelection; $ingredient : cs.IngredientsEntity) : cs.IngredientsSelection
	var $result : cs.IngredientsSelection
    $result := New collection
    $result = $ingredients.add($ingredient).toCollection()
    return $result
 

exposed Function getIngredientsWithSelected() : Collection
    var $ings : cs.IngredientsSelection
    var $final : Collection
    var $o : Object

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