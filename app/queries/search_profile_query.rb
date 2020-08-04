class SearchProfileQuery
  def self.execute(relation=Profile.all, query: '')
    relation.where('username ~* :q OR organization ~* :q OR location ~* :q
                   OR fullname ~* :q', { q: query })
  end

end
