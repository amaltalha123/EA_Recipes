Class extends DataClass


// exposed Function cancelRecipe($recipe : cs.RecipesEntity)
//     If ($recipe.ID <= 0)
        
//         // Supprimer les ingrédients orphelins
//         var $ings : cs.IngredientsSelection
//         var $ing : cs.IngredientsEntity
//         $ings := ds.Ingredients.query("RecipesID = :1"; $recipe.ID)
//         For each ($ing; $ings)
//             $ing.drop()
//         End for each
        
//         // Supprimer la recette temporaire
//         $recipe.drop()
        
//     End if

// Filter
exposed Function filterRecipes($searchText : Text; $favoriteOnly : Boolean;  $category : Text; $cuisine : Text; $selectedIngredients : Collection) : cs.RecipesSelection

    var $result : cs.RecipesSelection
    var $query : Text
    var $params : Collection
    var $ing : Object
    var $ingNames : Collection
    
    $result := ds.Recipes.all()
  
	if($searchText # "")
		$result := ds.Recipes.query("Title = :1"; "@"+$searchText+"@")
	End if
    // Filtre favoris
    If ($favoriteOnly = True)
        $result := $result.query("Favorites = true")
	End If 
    
    // Filtre catégorie
    If ($category # "")
        $result := $result.query("Category = :1"; $category)
    End if
    
    // Filtre cuisine
    If ($cuisine # "")
        $result := $result.query("Cuisine = :1"; $cuisine)
    End if
    
    // Filtre ingrédients cochés
    If ($selectedIngredients # Null)
        $ingNames := New collection()
        For each ($ing; $selectedIngredients)
            If ($ing.selected = True)
                $ingNames.push($ing.content.Item)
            End if
        End for each
        
        If ($ingNames.length > 0)
            var $ingName : Text
            For each ($ingName; $ingNames)
                $result := $result.query("ingredients.Item = :1"; $ingName)
            End for each
        End if
    End if
    
    return $result

exposed Function saveCookingStep($recipe : cs.RecipesEntity; $step : Object; $steps : Collection) : Collection
	var $result : Collection
    If ($steps = Null)
        $result := New collection()
    Else
        $result := $steps
    End if
    If (($step # Null) && ($step.step # ""))
		If (Length($step.step) > 0)
			$result.push($step)
		End if
    End if
    return $result

exposed Function deleteCookingStep($step : Object; $steps : Collection) : Collection
    var $result : Collection
    var $s : Object
    $result := New collection()
		For each ($s; $steps)
			If ($s.step # $step.step)
				$result.push($s)
			End if
		End for each
    return $result

exposed Function getCookingSteps($recipe : cs.RecipesEntity) : Collection
    var $steps : Collection
    var $result : Collection
    var $step : Text
    var $i : Integer
    
	$result := New collection()
    
    If ($recipe.CookingSteps # Null)
        $steps := $recipe.CookingSteps.steps
        If ($steps # Null)
            For each ($step; $steps)
                $result.push(New object("step"; $step))
            End for each
        End if
    End if
    return $result

