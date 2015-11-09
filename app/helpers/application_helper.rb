module ApplicationHelper
  def flash_class level
    case level
    when :notice then "alert-info"
    when :error then "alert-error"
    when :alert then "alert-warning"
    when :success then "alert-success"
    end
  end

  def interval_name interval
    if Settings.intervals.daily == interval
      interval_name = Date.today
    elsif Settings.intervals.monthly == interval
      interval_name = "#{Date.today.at_beginning_of_month} - #{Date.today.end_of_month}"
    elsif Settings.intervals.yearly == interval
      interval_name = "#{Date.today.at_beginning_of_year} - #{Date.today.end_of_year}"
    end
  end

  def payment_method_name payment_method
    Settings.payment_methods.all == payment_method ? "All payment method" : PaymentMethod.find(payment_method).name
  end

  def payment_type class_name
    Settings.payment_class.user_income == class_name ? Settings.types.income : Settings.types.expense
  end

  def payment_category class_name, object
    Settings.payment_class.user_income == class_name ? object.income_category.name : object.expense_category.name
  end
end
