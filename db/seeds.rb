# Example data for case study

require 'open-uri'

[User, Category, Collection, Monument, Picture].each(&:delete_all)

ActiveRecord::Base.transaction do
  categories = Category.create!([{ name: 'Town hall' }, { name: 'Castle' }])
  user = User.create(username: 'John Doe', email: 'user@example.com', password: 'password', password_confirmation: 'password')

  collection = Collection.create!(user: user, name: 'Visited places')
  monument = Monument.create!(
      collection: collection,
      category: categories.first,
      name: 'Palazzo Ducale',
      description: "The Doge's Palace is a palace built in Venetian Gothic style, "\
                   "and one of the main landmarks of the city of Venice, northern Italy."
  )

  def download(uri)
    dest = Tempfile.new(%w(seed .jpg))
    src = open(uri)

    IO.copy_stream(src, dest)
    dest
  end

  Picture.create!(
      monument: monument,
      image: download('http://www.greatbuildings.com/gbc/images/cid_1160283763_Doges_Palace_02.jpg'),
      name: 'Front view',
      description: "Doge's palace at noon",
      taken_at: Date.yesterday
  )

  Picture.create!(
      monument: monument,
      image: download('http://2.bp.blogspot.com/-qffbzF4XUd4/UPnWOm4AcJI/AAAAAAADhvc/BERhMpCYKiw/s1600/Doges_Palace3.jpg'),
      name: 'Interior',
      taken_at: Date.yesterday
  )
end