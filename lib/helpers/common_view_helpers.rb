module CommonViewHelpers

  ##
  # 文字列からEメールアドレス抽出
  def get_email(str)
    str.scan(/[0-9a-zA-Z\-\_]+@[0-9a-zA-Z\-\_\.]+\.[0-9a-zA-Z\-\_]+/) rescue nil
  end

  ##
  # メールアドレスをmail_toでラップして文字列を返す
  #
  def wrap_mail_to(str)
    begin
      get_email(str).each do |email|
        str.gsub!(email, ApplicationController.helpers.mail_to(email))
      end

      return str.html_safe
    rescue
      nil
    end
  end

  def content_tag_if(condition, name, content_or_options_with_block = nil, options = nil, escape = true, &block)
    if condition
      content_tag(name, content_or_options_with_block, options, escape, &block)
    else
      if block_given?
        capture(&block)
      else
        content_or_options_with_block
      end
    end
  end


  ##
  # trとtdを生成
  def simple_table_item_tag(model_instance, attribute, value = nil, type: "")
    html = ""
    html << content_tag(:th, model_instance.class.human_attribute_name(attribute).html_safe, class: "span3")
    case type.to_sym
    when :checkbox
      html << content_tag(:td, ((value || model_instance.send(attribute)) ? "有" : "無"))
    else
      html << content_tag(:td, value || model_instance.send(attribute))
    end
    content_tag(:tr, html.html_safe)
  end
end
