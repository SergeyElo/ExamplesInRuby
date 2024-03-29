#
# Этот класс представляет последовательность чисел, характеризующуюся тремя
# параметрами: from, to и by (от, до и через). Числа х в этой последовательности
# удовлетворяют следующим двум ограничениям:
#
# from <= х <= to
# х = from + n*by, где п - целое число
#
class Sequence
  # Это класс относится к перечисляемым - enumerable; это определяется
  # приведенным ниже итератором each.
  include Enumerable # Включение в класс методов этого модуля
  # Метод initialize играет особую роль; он вызывается автоматически для
  # инициализации заново создаваемых экземпляров класса
  def initialize(from, to, by)
    # Наши параметры просто сохраняются в переменных экземпляра для их
    # дальнейшего использования
    @from, @to, @by = from, to, by # Обратите внимание на параллельное
    # присваивание и на префикс @
  end
  # Этот итератор востребован модулем Enumerable
  def each
    x = @from # Старт в начальной точке
    while x <= @to # Пока мы не достигли конечной точки
      yield x # Передача х блоку, связанному с итератором
      x += @by # Приращение х
    end
  end
  # Определение метода length (следующего за массивами) для возвращения
  # количества значений в последовательности
  def length
    return 0 if @from > @to # Заметьте, что if используется в качестве
    # оператора-модификатора
    Integer((@to-@from)/@by) +1 # Вычисление и возвращение длины
    # последовательности
  end
  # Определение другого имени для одного и того же метода.
  # Наличие нескольких имен у Ruby-методов - вполне обычная практика
  alias size length # Теперь size является синонимом length
  # Переопределение оператора доступа к элементам массива, чтобы предоставить
  # произвольный доступ к элементам sequence
  def[](index)
    return nil if index < 0 # Возвращение nil для отрицательных индексов
    v = @from + index*@by # Вычисление значения
    if v <= @to # Если оно является частью последовательности
      v # Вернуть его
    else # Если нет...
      nil # Вернуть nil
    end
  end
  # Переопределение арифметических операторов для возвращения новых объектов
  # Sequence
  def *(factor)
    Sequence.new(@from*factor, @to*factor, @by*factor)
  end
  def +(offset)
    Sequence.new(@from+offset, @to+offset, @by)
  end
end

s = Sequence.new(1, 10, 2) # От 1 до 10 через 2
s.each {|x| print "#{x} "} # Выводит "13579"
print "\n#{s[s.size-1]}"  # Выводит 9
t = (s+1)*2
