module LogsHelper

  def free_input(key = nil, value = nil)
    html = <<-"EOS".strip_heredoc
            <div class='search_input deletable_input_area'>
              キー(※完全一致)
              #{text_field_tag("input_key[]", key)}
              値(※部分一致)
              #{text_field_tag("input_value[]", value)}
              #{link_to("削除", '', onclick: "delete_input_area(this);return false;", class: "btn btn-mini btn-danger")}
            </div>
          EOS
    html.html_safe
  end

end
