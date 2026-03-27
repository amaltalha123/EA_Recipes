Class extends Entity

exposed Function dropRecipeWithIngredients() : Boolean
    var $status : Object
    $status := This.drop()
    return $status.success