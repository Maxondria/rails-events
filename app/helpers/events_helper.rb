module EventsHelper
  def price(event)
    return "Free" if event.free?
    number_to_currency(event.price, precision: 0)
  end

  def format_time(event)
    event.starts_at.strftime("%B %d at %I:%M %P")
  end
end
