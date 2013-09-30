module ApplicationHelper
  include CommonViewHelpers

  # ransack日付検索用(年月日のみ)
  def make_search_date_field(f, target)
    html = ""
    html << if f.nil?
              select_date(instance_variable_get("@#{target.to_s}"), {include_blank: true, prefix: target, use_month_numbers: true}, { class: 'input-small search-query'})
            else
              f.input_field(target.to_sym, :as => :date, :required => false, :use_month_numbers => true, :include_blank => true, :date_separator => "/ ", :label => false, :input_html => { :class => 'input-medium search-query' })
            end
    return html.html_safe
  end

  # 前月＋今月＋本日＋クリアボタン作成
  def date_btn
    html = ""
    html << link_to("前月","javascript:void(0)", class:   "btn search_prev_month btn-mini") + " "
    html << link_to("今月","javascript:void(0)", class:   "btn search_this_month btn-mini") + " "
    html << link_to("本日","javascript:void(0)", class:   "btn search_today btn-mini") + " "
    html << link_to("クリア","javascript:void(0)", class: "btn search_clear btn-mini") + " "
    html.html_safe
  end

  # 日時の検索用(フルセット)
  def make_datetime_search_field(f,label_name,target)
    content_tag(:div,
      label_name.html_safe + " " + make_search_date_field(f, "#{target}_gteq".to_sym) + " - " + make_search_date_field(f, "#{target}_lt".to_sym) + date_btn,
      class: "search_row"
    )
  end
end
