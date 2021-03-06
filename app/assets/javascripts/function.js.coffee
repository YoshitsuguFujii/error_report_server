##
# 年月日と加算月からnヶ月後、nヶ月前の日付を求める
# year 年
# month 月
# day 日
# addMonths 加算月。マイナス指定でnヶ月前も設定可能
@computeMonth =(year, month, day, addMonths) ->
  month += addMonths
  endDay = getMonthEndDay(year, month)
  if day > endDay
    day = endDay
  dt = new Date(year, month - 1, day)
  return(dt)

##
#  年月を指定して月初日を求める関数
#  year 年
#  month 月
@getMonthStartDate =(year, month)  ->
  dt = new Date(year, month, 1)

##
#  年月を指定して1月末日を求める関数
#  year 年
#  month 月
@getMonthEndDate =(year, month)  ->
  dt = new Date(year, (month + 1), 0)

##
#  年月を指定して月末日を求める関数
#  year 年
#  month 月
@getMonthEndDay =(year, month)  ->
  # 日付を0にすると前月の末日を指定したことになります
  # 指定月の翌月の0日を取得して末日を求めます
  # そのため、ここでは month - 1 は行いません
  dt = new Date(year, month, 0)
  return(dt.getDate())

##
#
# 先月を求める
@last_month = ->
  date = new Date()
  last_date = computeMonth(date.getFullYear(),(date.getMonth() + 1),date.getDate(), -1)
  last_date


##
# 自分を含むdiv.deletable_input_areaを削除
#
@delete_input_area =(self) ->
  #$(self).parent('.deletable_input_area').slideUp(200, -> $(@).remove())
  $(self).parents('.deletable_input_area').remove()

##
# input入力欄を増やす
#
@add_input =(url) ->
  $.ajax
    url: url
    type: "GET"
    #data: "page=" + cnt + "&authenticity_token=" + $("#add_count").val()
    success: (rtn) ->
      $('.free_input_area').append(rtn)

    error: (XMLHttpRequest, textStatus, errorThrown) ->
      console.log("XMLHttpRequest : " + XMLHttpRequest.status)
      console.log("textStatus : " + textStatus)
      console.log("errorThrown : " + errorThrown.message)
