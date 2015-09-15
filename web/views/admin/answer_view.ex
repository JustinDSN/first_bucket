defmodule FirstBucket.Admin.AnswerView do
  use FirstBucket.Web, :view

  def truncate_string(content, length) do
    if length > String.length(content) do
      length = String.length(content) 
    end
    
    String.slice(content, 0, length)
  end
end
