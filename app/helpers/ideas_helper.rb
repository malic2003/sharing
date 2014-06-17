module IdeasHelper
  def all_tags
    Idea.tag_counts_on(:tags)
  end
end
