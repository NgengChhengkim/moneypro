var show_type = function(type) {
  income_category = $(".income_category");
  expense_category = $(".expense_category");
  if(type == "income") {
    income_category.show();
    expense_category.hide();
  }else if(type == "expense") {
    income_category.hide();
    expense_category.show();
  }else {
    income_category.hide();
    expense_category.hide();
  }
}

$(document).on("page:update", function() {
  show_type($(".type_select").val());
  $(".type_select").bind('change',function () {
    type = $(this).val();
    show_type(type);
  });
})
