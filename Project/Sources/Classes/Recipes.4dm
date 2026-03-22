Class extends DataClass
exposed Function getLookupData($type : Text) : Collection
    var $result : Collection
    var $final : Collection
    var $item : Text
    var $o : Object
    
    $result := New collection
    $final := New collection
    
    Case of 
        : ($type="Categories")
            $result := ds.Recipes.all().distinct("Category")
            For each ($item; $result)
                $o := New object
                $o.content := $item
                $o.count := ds.Recipes.query("Category = :1"; $item).length
                $final.push($o)
            End for each
            
        : ($type="Cuisine")
            $result := ds.Recipes.all().distinct("Cuisine")
            For each ($item; $result)
                $o := New object
                $o.content := $item
                $o.count := ds.Recipes.query("Cuisine = :1"; $item).length
                $final.push($o)
            End for each

        : ($type="Ingredients")
            $result := ds.Ingredients.all().distinct("Item")
            For each ($item; $result)
                $o := New object
                $o.content := $item
                // Nombre de recettes distinctes utilisant cet ingrédient
                $o.count := ds.Ingredients.query("Item = :1"; $item)\
                    .distinct("RecipesID").length
                $final.push($o)
            End for each
		: ($type="Favorites")
			var $favSelection : cs.RecipesSelection
			var $recipe : cs.RecipesEntity
			$favSelection := ds.Recipes.query("Favorites = true").orderBy("ID desc")
			For each ($recipe; $favSelection)
				$o := New object
				$o.content := $recipe.Title
				$o.count := 1
				$final.push($o)
			End for each
          
    End case
    
    return $final

exposed Function getTotalRecips() : Integer
	$result := ds.Recipes.all().length
	return $result

exposed Function getTotalFavorites() : Integer
	$favSelection := ds.Recipes.query("Favorites = true").length
	return $favSelection

exposed Function getCookingSteps($recipe : cs.RecipesEntity) : Collection
    var $steps : Collection
    var $result : Collection
    var $step : Text
    var $i : Integer
    
    $steps := $recipe.CookingSteps.steps
    $result := New collection
    
    For each ($step; $steps)
        $result.push(New object("step"; $step))
    End for each
    
    return $result

exposed Function getSelectedRecipe($id : Integer) : cs.RecipesEntity
    var $recipe : cs.RecipesEntity
    $recipe := ds.Recipes.query("ID = :1"; $id).first()
    return $recipe

exposed Function getAllRecipe() : cs.RecipesSelection
    var $recipes : cs.RecipesSelection
    $recipes := ds.Recipes.all()
    return $recipes

	
exposed Function getRecipesByLookup($type : Text; $content : Text) : cs.RecipesSelection
    
    Case of 
        : ($type="Categories")
            return ds.Recipes.query("Category = :1"; $content).orderBy("ID desc")
            
        : ($type="Cuisine")
            return ds.Recipes.query("Cuisine = :1"; $content).orderBy("ID desc")
            
        : ($type="Ingredients")
            return ds.Recipes.query("ingredients.Item = :1"; $content).orderBy("ID desc")
    End case