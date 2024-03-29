# puts $: - вывод всех директорий для подключения файлов  помощью require
# добавить папку в список можно так:  $: << "Folder"
require "date"
# подключить из текущей директории файл colors.rb - там установка цвета
require Dir.pwd + "/colors.rb"
def cal(year, columns)
  mn = ["", "Январь", "Февраль", "Март", "Апрель", "Май", "Июнь",
                "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
  date = Date.new(year, 1, 1, Date::ENGLAND)
  months = (1..12).collect do |month|
    rows = [mn[month].center(20).bg_gray.black, "Пн Вт Ср Чт Пт Сб Вс".brown]
    days = []
    # Корректировка дня недели wday
    # Англия: 0-Вс 1-Пн 2-Вт 3-Ср 4-Чт 5-Пт 6-Сб
    # Россия: 0-Пн 1-Вт 2-Ср 3-Чт 4-Пт 5-Сб 6-Вс
    date.wday == 0 ? r_day = 6 :  r_day = date.wday - 1
    r_day.times { days.push "  " }
    # Было: date.wday.times { days.push "  " }
    while date.month == month
      days.push("%2d" % date.mday)
      date += 1
    end
    (42 - days.length).times { days.push "  " }
    days.each_slice(7) { |week| rows.push(week.join " " )}
    next rows
  end
  mpr = (columns + 2).div 22
  mpr = 12.div((12 + mpr - 1).div mpr)
  width = mpr * 22 - 2
  rows = ["Календарь на #{year} год".center(width).green.bold.italic]
  months.each_slice(mpr) do |slice|
    slice[0].each_index do |i|
      rows.push(slice.map {|a| a[i]}.join "  ")
    end
  end
  return rows.join("\n")
end
columns = begin Integer(4 || "")
rescue
  begin require 'io/console'; IO.console.winsize[1]
  rescue LoadError
    begin Integer(`tput cols`)
    rescue
      80;
    end;
  end;
          end

puts cal(2021, 130)


