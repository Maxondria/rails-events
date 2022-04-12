module EventsHelper
  def price(event)
    return 'Free' if event.free?
    number_to_currency(event.price, precision: 0)
  end

  def format_time(event)
    event.starts_at.strftime('%B %d at %I:%M %P')
  end

  def main_image(event)
    if event.main_image.attached?
      image_tag(event.main_image.variant(resize_to_limit: [75, 75]))
    else
      image_tag('placeholder.png')
    end
  end
end
