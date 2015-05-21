module AlbumsHelper
  def select_film(name, selected = nil)
    select_tag(name, options_for_select(
      Film.order('name').load.map{ |x| [x.name, x.id] } + [['', nil]],
      [selected]))
  end
  def select_person(name, selected = nil)
    select_tag(name, options_for_select(
      Person.order('name').load.map{ |x| [x.name, x.id] } + [['', nil]],
      [selected]))
  end
end
